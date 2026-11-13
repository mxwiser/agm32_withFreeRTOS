module user_ip (
  input              sys_clock,
  input              bus_clock,
  input              resetn,
  input              stop,
  input       [1:0]  mem_ahb_htrans,
  input              mem_ahb_hready,
  input              mem_ahb_hwrite,
  input       [31:0] mem_ahb_haddr,
  input       [2:0]  mem_ahb_hsize,
  input       [2:0]  mem_ahb_hburst,
  input       [31:0] mem_ahb_hwdata,
  output tri1        mem_ahb_hreadyout,
  output tri0        mem_ahb_hresp,
  output tri0 [31:0] mem_ahb_hrdata,
  output tri0        slave_ahb_hsel,
  output tri1        slave_ahb_hready,
  input              slave_ahb_hreadyout,
  output tri0 [1:0]  slave_ahb_htrans,
  output tri0 [2:0]  slave_ahb_hsize,
  output tri0 [2:0]  slave_ahb_hburst,
  output tri0        slave_ahb_hwrite,
  output tri0 [31:0] slave_ahb_haddr,
  output tri0 [31:0] slave_ahb_hwdata,
  input              slave_ahb_hresp,
  input       [31:0] slave_ahb_hrdata,
  output tri0 [3:0]  ext_dma_DMACBREQ,
  output tri0 [3:0]  ext_dma_DMACLBREQ,
  output tri0 [3:0]  ext_dma_DMACSREQ,
  output tri0 [3:0]  ext_dma_DMACLSREQ,
  input       [3:0]  ext_dma_DMACCLR,
  input       [3:0]  ext_dma_DMACTC,
  output tri0 [3:0]  local_int
);
assign slave_ahb_hready  = 1'b1;

// The bridge exposes word registers at 0x60000000 + 4 * index.
// J3 ADC1 is PIN_19 / ADC_IN9; J4 ADC2 is PIN_18 / ADC_IN8.
wire apb_psel, apb_penable, apb_pwrite;
wire [3:0] apb_paddr;
wire [31:0] apb_pwdata;
wire [3:0] apb_pstrb;
wire [2:0] apb_pprot;
reg [31:0] apb_prdata;

ahb2apb #(4, 32) bridge (
  .reset(!resetn), .ahb_clock(sys_clock), .ahb_hmastlock(1'b0),
  .ahb_htrans(mem_ahb_htrans), .ahb_hsel(1'b1),
  .ahb_hready(mem_ahb_hready), .ahb_hwrite(mem_ahb_hwrite),
  .ahb_haddr(mem_ahb_haddr[3:0]), .ahb_hsize(mem_ahb_hsize),
  .ahb_hburst(mem_ahb_hburst), .ahb_hprot(4'b0011),
  .ahb_hwdata(mem_ahb_hwdata), .ahb_hrdata(mem_ahb_hrdata),
  .ahb_hreadyout(mem_ahb_hreadyout), .ahb_hresp(mem_ahb_hresp),
  .apb_clock(bus_clock), .apb_psel(apb_psel), .apb_penable(apb_penable),
  .apb_pwrite(apb_pwrite), .apb_paddr(apb_paddr), .apb_pwdata(apb_pwdata),
  .apb_pstrb(apb_pstrb), .apb_pprot(apb_pprot),
  .apb_pready(1'b1), .apb_pslverr(1'b0), .apb_prdata(apb_prdata)
);

// 200 MHz bus / (2 * (9 + 1)) = 10 MHz ADC serial clock.
reg [3:0] adc_clk_div;
reg adc_sclk;
always @(posedge bus_clock or negedge resetn) begin
  if (!resetn) begin
    adc_clk_div <= 0;
    adc_sclk <= 0;
  end else if (adc_clk_div == 9) begin
    adc_clk_div <= 0;
    adc_sclk <= !adc_sclk;
  end else begin
    adc_clk_div <= adc_clk_div + 1'b1;
  end
end

wire [11:0] adc1_data, adc2_data;
wire adc1_eoc, adc2_eoc;
reg adc1_eoc_d, adc2_eoc_d;
reg [11:0] adc1_latest, adc2_latest;
reg adc1_valid, adc2_valid;
alta_adc adc1_inst (.enb(!resetn), .sclk(adc_sclk), .insel(5'd10),
                    .stop(stop), .db(adc1_data), .eoc(adc1_eoc));
alta_adc adc2_inst (.enb(!resetn), .sclk(adc_sclk), .insel(5'd9),
                    .stop(stop), .db(adc2_data), .eoc(adc2_eoc));

always @(posedge bus_clock or negedge resetn) begin
  if (!resetn) begin
    adc1_eoc_d <= 1'b0;
    adc2_eoc_d <= 1'b0;
    adc1_latest <= 0;
    adc2_latest <= 0;
    adc1_valid <= 1'b0;
    adc2_valid <= 1'b0;
  end else begin
    // EOC is active low; sample after its falling edge as in the AGM example.
    adc1_eoc_d <= !adc1_eoc;
    adc2_eoc_d <= !adc2_eoc;
    if (!adc1_eoc && !adc1_eoc_d) begin
      adc1_latest <= adc1_data;
      adc1_valid <= 1'b1;
    end
    if (!adc2_eoc && !adc2_eoc_d) begin
      adc2_latest <= adc2_data;
      adc2_valid <= 1'b1;
    end
  end
end

// Capture during APB setup so the value remains stable through access.
always @(posedge bus_clock or negedge resetn) begin
  if (!resetn) apb_prdata <= 0;
  else if (apb_psel && !apb_penable && !apb_pwrite) begin
    case (apb_paddr)
      4'h0: apb_prdata <= {30'b0, adc2_valid, adc1_valid};
      4'h4: apb_prdata <= {20'b0, adc1_latest};
      4'h8: apb_prdata <= {20'b0, adc2_latest};
      default:  apb_prdata <= 0;
    endcase
  end
end
endmodule
