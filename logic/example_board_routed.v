`timescale 1 ps/ 1 ps

module example_board(
	CAN0_RX0,
	CAN0_TX0,
	GPIO4_4,
	GPIO5_0,
	GPIO5_1,
	GPIO5_2,
	GPIO5_3,
	PIN_HSE,
	PIN_HSI,
	PIN_OSC,
	SPI0_CSN,
	SPI0_SCK,
	SPI0_SI_IO0,
	UART0_UARTRXD,
	UART0_UARTTXD);
input	CAN0_RX0;
output	CAN0_TX0;
inout	GPIO4_4;
inout	GPIO5_0;
inout	GPIO5_1;
inout	GPIO5_2;
inout	GPIO5_3;
input	PIN_HSE;
input	PIN_HSI;
input	PIN_OSC;
output	SPI0_CSN;
output	SPI0_SCK;
inout	SPI0_SI_IO0;
input	UART0_UARTRXD;
output	UART0_UARTTXD;

//wire	gnd;
//wire	vcc;
wire	PIN_HSE_i_o;
wire	PIN_HSI_i_o;
wire	PIN_OSC_i_o;
wire	[4:0] PLL_CLKOUT;
//wire	PLL_CLKOUT[0];
//wire	PLL_CLKOUT[1];
//wire	PLL_CLKOUT[2];
//wire	PLL_CLKOUT[3];
//wire	PLL_CLKOUT[4];
wire	PLL_ENABLE;
wire	PLL_LOCK;
wire	bus_clk;
wire	[3:0] ext_dma_DMACCLR;
//wire	ext_dma_DMACCLR[0];
//wire	ext_dma_DMACCLR[1];
//wire	ext_dma_DMACCLR[2];
//wire	ext_dma_DMACCLR[3];
wire	[3:0] ext_dma_DMACTC;
//wire	ext_dma_DMACTC[0];
//wire	ext_dma_DMACTC[1];
//wire	ext_dma_DMACTC[2];
//wire	ext_dma_DMACTC[3];
wire	[7:0] gpio0_io_in;
//wire	gpio0_io_in[0];
//wire	gpio0_io_in[1];
//wire	gpio0_io_in[2];
//wire	gpio0_io_in[3];
//wire	gpio0_io_in[4];
//wire	gpio0_io_in[5];
//wire	gpio0_io_in[6];
//wire	gpio0_io_in[7];
wire	[7:0] gpio0_io_out_data;
//wire	gpio0_io_out_data[0];
//wire	gpio0_io_out_data[1];
//wire	gpio0_io_out_data[2];
//wire	gpio0_io_out_data[3];
//wire	gpio0_io_out_data[4];
//wire	gpio0_io_out_data[5];
//wire	gpio0_io_out_data[6];
//wire	gpio0_io_out_data[7];
wire	[7:0] gpio0_io_out_en;
//wire	gpio0_io_out_en[0];
//wire	gpio0_io_out_en[1];
//wire	gpio0_io_out_en[2];
//wire	gpio0_io_out_en[3];
//wire	gpio0_io_out_en[4];
//wire	gpio0_io_out_en[5];
//wire	gpio0_io_out_en[6];
//wire	gpio0_io_out_en[7];
wire	[7:0] gpio1_io_out_data;
//wire	gpio1_io_out_data[0];
//wire	gpio1_io_out_data[1];
//wire	gpio1_io_out_data[2];
//wire	gpio1_io_out_data[3];
//wire	gpio1_io_out_data[4];
//wire	gpio1_io_out_data[5];
//wire	gpio1_io_out_data[6];
//wire	gpio1_io_out_data[7];
wire	[7:0] gpio1_io_out_en;
//wire	gpio1_io_out_en[0];
//wire	gpio1_io_out_en[1];
//wire	gpio1_io_out_en[2];
//wire	gpio1_io_out_en[3];
//wire	gpio1_io_out_en[4];
//wire	gpio1_io_out_en[5];
//wire	gpio1_io_out_en[6];
//wire	gpio1_io_out_en[7];
wire	[7:0] gpio2_io_out_data;
//wire	gpio2_io_out_data[0];
//wire	gpio2_io_out_data[1];
//wire	gpio2_io_out_data[2];
//wire	gpio2_io_out_data[3];
//wire	gpio2_io_out_data[4];
//wire	gpio2_io_out_data[5];
//wire	gpio2_io_out_data[6];
//wire	gpio2_io_out_data[7];
wire	[7:0] gpio2_io_out_en;
//wire	gpio2_io_out_en[0];
//wire	gpio2_io_out_en[1];
//wire	gpio2_io_out_en[2];
//wire	gpio2_io_out_en[3];
//wire	gpio2_io_out_en[4];
//wire	gpio2_io_out_en[5];
//wire	gpio2_io_out_en[6];
//wire	gpio2_io_out_en[7];
wire	[7:0] gpio3_io_out_data;
//wire	gpio3_io_out_data[0];
//wire	gpio3_io_out_data[1];
//wire	gpio3_io_out_data[2];
//wire	gpio3_io_out_data[3];
//wire	gpio3_io_out_data[4];
//wire	gpio3_io_out_data[5];
//wire	gpio3_io_out_data[6];
//wire	gpio3_io_out_data[7];
wire	[7:0] gpio3_io_out_en;
//wire	gpio3_io_out_en[0];
//wire	gpio3_io_out_en[1];
//wire	gpio3_io_out_en[2];
//wire	gpio3_io_out_en[3];
//wire	gpio3_io_out_en[4];
//wire	gpio3_io_out_en[5];
//wire	gpio3_io_out_en[6];
//wire	gpio3_io_out_en[7];
wire	[7:0] gpio4_io_in;
//wire	gpio4_io_in[0];
//wire	gpio4_io_in[1];
//wire	gpio4_io_in[2];
//wire	gpio4_io_in[3];
//wire	gpio4_io_in[4];
//wire	gpio4_io_in[5];
//wire	gpio4_io_in[6];
//wire	gpio4_io_in[7];
wire	[7:0] gpio4_io_out_data;
//wire	gpio4_io_out_data[0];
//wire	gpio4_io_out_data[1];
//wire	gpio4_io_out_data[2];
//wire	gpio4_io_out_data[3];
//wire	gpio4_io_out_data[4];
//wire	gpio4_io_out_data[5];
//wire	gpio4_io_out_data[6];
//wire	gpio4_io_out_data[7];
wire	[7:0] gpio4_io_out_en;
//wire	gpio4_io_out_en[0];
//wire	gpio4_io_out_en[1];
//wire	gpio4_io_out_en[2];
//wire	gpio4_io_out_en[3];
//wire	gpio4_io_out_en[4];
//wire	gpio4_io_out_en[5];
//wire	gpio4_io_out_en[6];
//wire	gpio4_io_out_en[7];
wire	[7:0] gpio5_io_in;
//wire	gpio5_io_in[0];
//wire	gpio5_io_in[1];
//wire	gpio5_io_in[2];
//wire	gpio5_io_in[3];
//wire	gpio5_io_in[4];
//wire	gpio5_io_in[5];
//wire	gpio5_io_in[6];
//wire	gpio5_io_in[7];
wire	[7:0] gpio5_io_out_data;
//wire	gpio5_io_out_data[0];
//wire	gpio5_io_out_data[1];
//wire	gpio5_io_out_data[2];
//wire	gpio5_io_out_data[3];
//wire	gpio5_io_out_data[4];
//wire	gpio5_io_out_data[5];
//wire	gpio5_io_out_data[6];
//wire	gpio5_io_out_data[7];
wire	[7:0] gpio5_io_out_en;
//wire	gpio5_io_out_en[0];
//wire	gpio5_io_out_en[1];
//wire	gpio5_io_out_en[2];
//wire	gpio5_io_out_en[3];
//wire	gpio5_io_out_en[4];
//wire	gpio5_io_out_en[5];
//wire	gpio5_io_out_en[6];
//wire	gpio5_io_out_en[7];
wire	[7:0] gpio6_io_in;
//wire	gpio6_io_in[0];
//wire	gpio6_io_in[1];
//wire	gpio6_io_in[2];
//wire	gpio6_io_in[3];
//wire	gpio6_io_in[4];
//wire	gpio6_io_in[5];
//wire	gpio6_io_in[6];
//wire	gpio6_io_in[7];
wire	[7:0] gpio6_io_out_data;
//wire	gpio6_io_out_data[0];
//wire	gpio6_io_out_data[1];
//wire	gpio6_io_out_data[2];
//wire	gpio6_io_out_data[3];
//wire	gpio6_io_out_data[4];
//wire	gpio6_io_out_data[5];
//wire	gpio6_io_out_data[6];
//wire	gpio6_io_out_data[7];
wire	[7:0] gpio6_io_out_en;
//wire	gpio6_io_out_en[0];
//wire	gpio6_io_out_en[1];
//wire	gpio6_io_out_en[2];
//wire	gpio6_io_out_en[3];
//wire	gpio6_io_out_en[4];
//wire	gpio6_io_out_en[5];
//wire	gpio6_io_out_en[6];
//wire	gpio6_io_out_en[7];
wire	[7:0] gpio7_io_in;
//wire	gpio7_io_in[0];
//wire	gpio7_io_in[1];
//wire	gpio7_io_in[2];
//wire	gpio7_io_in[3];
//wire	gpio7_io_in[4];
//wire	gpio7_io_in[5];
//wire	gpio7_io_in[6];
//wire	gpio7_io_in[7];
wire	[7:0] gpio7_io_out_data;
//wire	gpio7_io_out_data[0];
//wire	gpio7_io_out_data[1];
//wire	gpio7_io_out_data[2];
//wire	gpio7_io_out_data[3];
//wire	gpio7_io_out_data[4];
//wire	gpio7_io_out_data[5];
//wire	gpio7_io_out_data[6];
//wire	gpio7_io_out_data[7];
wire	[7:0] gpio7_io_out_en;
//wire	gpio7_io_out_en[0];
//wire	gpio7_io_out_en[1];
//wire	gpio7_io_out_en[2];
//wire	gpio7_io_out_en[3];
//wire	gpio7_io_out_en[4];
//wire	gpio7_io_out_en[5];
//wire	gpio7_io_out_en[6];
//wire	gpio7_io_out_en[7];
wire	[7:0] gpio8_io_out_data;
//wire	gpio8_io_out_data[0];
//wire	gpio8_io_out_data[1];
//wire	gpio8_io_out_data[2];
//wire	gpio8_io_out_data[3];
//wire	gpio8_io_out_data[4];
//wire	gpio8_io_out_data[5];
//wire	gpio8_io_out_data[6];
//wire	gpio8_io_out_data[7];
wire	[7:0] gpio8_io_out_en;
//wire	gpio8_io_out_en[0];
//wire	gpio8_io_out_en[1];
//wire	gpio8_io_out_en[2];
//wire	gpio8_io_out_en[3];
//wire	gpio8_io_out_en[4];
//wire	gpio8_io_out_en[5];
//wire	gpio8_io_out_en[6];
//wire	gpio8_io_out_en[7];
wire	[7:0] gpio9_io_out_data;
//wire	gpio9_io_out_data[0];
//wire	gpio9_io_out_data[1];
//wire	gpio9_io_out_data[2];
//wire	gpio9_io_out_data[3];
//wire	gpio9_io_out_data[4];
//wire	gpio9_io_out_data[5];
//wire	gpio9_io_out_data[6];
//wire	gpio9_io_out_data[7];
wire	[7:0] gpio9_io_out_en;
//wire	gpio9_io_out_en[0];
//wire	gpio9_io_out_en[1];
//wire	gpio9_io_out_en[2];
//wire	gpio9_io_out_en[3];
//wire	gpio9_io_out_en[4];
//wire	gpio9_io_out_en[5];
//wire	gpio9_io_out_en[6];
//wire	gpio9_io_out_en[7];
wire	[31:0] \macro_inst|mem_ahb_haddr ;
//wire	\macro_inst|mem_ahb_haddr [0];
//wire	\macro_inst|mem_ahb_haddr [10];
//wire	\macro_inst|mem_ahb_haddr [11];
//wire	\macro_inst|mem_ahb_haddr [12];
//wire	\macro_inst|mem_ahb_haddr [13];
//wire	\macro_inst|mem_ahb_haddr [14];
//wire	\macro_inst|mem_ahb_haddr [15];
//wire	\macro_inst|mem_ahb_haddr [16];
//wire	\macro_inst|mem_ahb_haddr [17];
//wire	\macro_inst|mem_ahb_haddr [18];
//wire	\macro_inst|mem_ahb_haddr [19];
//wire	\macro_inst|mem_ahb_haddr [1];
//wire	\macro_inst|mem_ahb_haddr [20];
//wire	\macro_inst|mem_ahb_haddr [21];
//wire	\macro_inst|mem_ahb_haddr [22];
//wire	\macro_inst|mem_ahb_haddr [23];
//wire	\macro_inst|mem_ahb_haddr [24];
//wire	\macro_inst|mem_ahb_haddr [25];
//wire	\macro_inst|mem_ahb_haddr [26];
//wire	\macro_inst|mem_ahb_haddr [27];
//wire	\macro_inst|mem_ahb_haddr [28];
//wire	\macro_inst|mem_ahb_haddr [29];
//wire	\macro_inst|mem_ahb_haddr [2];
//wire	\macro_inst|mem_ahb_haddr [30];
//wire	\macro_inst|mem_ahb_haddr [31];
//wire	\macro_inst|mem_ahb_haddr [3];
//wire	\macro_inst|mem_ahb_haddr [4];
//wire	\macro_inst|mem_ahb_haddr [5];
//wire	\macro_inst|mem_ahb_haddr [6];
//wire	\macro_inst|mem_ahb_haddr [7];
//wire	\macro_inst|mem_ahb_haddr [8];
//wire	\macro_inst|mem_ahb_haddr [9];
wire	[2:0] \macro_inst|mem_ahb_hburst ;
//wire	\macro_inst|mem_ahb_hburst [0];
//wire	\macro_inst|mem_ahb_hburst [1];
//wire	\macro_inst|mem_ahb_hburst [2];
wire	\macro_inst|mem_ahb_hready ;
wire	[2:0] \macro_inst|mem_ahb_hsize ;
//wire	\macro_inst|mem_ahb_hsize [0];
//wire	\macro_inst|mem_ahb_hsize [1];
//wire	\macro_inst|mem_ahb_hsize [2];
wire	[1:0] \macro_inst|mem_ahb_htrans ;
//wire	\macro_inst|mem_ahb_htrans [0];
//wire	\macro_inst|mem_ahb_htrans [1];
wire	[31:0] \macro_inst|mem_ahb_hwdata ;
//wire	\macro_inst|mem_ahb_hwdata [0];
//wire	\macro_inst|mem_ahb_hwdata [10];
//wire	\macro_inst|mem_ahb_hwdata [11];
//wire	\macro_inst|mem_ahb_hwdata [12];
//wire	\macro_inst|mem_ahb_hwdata [13];
//wire	\macro_inst|mem_ahb_hwdata [14];
//wire	\macro_inst|mem_ahb_hwdata [15];
//wire	\macro_inst|mem_ahb_hwdata [16];
//wire	\macro_inst|mem_ahb_hwdata [17];
//wire	\macro_inst|mem_ahb_hwdata [18];
//wire	\macro_inst|mem_ahb_hwdata [19];
//wire	\macro_inst|mem_ahb_hwdata [1];
//wire	\macro_inst|mem_ahb_hwdata [20];
//wire	\macro_inst|mem_ahb_hwdata [21];
//wire	\macro_inst|mem_ahb_hwdata [22];
//wire	\macro_inst|mem_ahb_hwdata [23];
//wire	\macro_inst|mem_ahb_hwdata [24];
//wire	\macro_inst|mem_ahb_hwdata [25];
//wire	\macro_inst|mem_ahb_hwdata [26];
//wire	\macro_inst|mem_ahb_hwdata [27];
//wire	\macro_inst|mem_ahb_hwdata [28];
//wire	\macro_inst|mem_ahb_hwdata [29];
//wire	\macro_inst|mem_ahb_hwdata [2];
//wire	\macro_inst|mem_ahb_hwdata [30];
//wire	\macro_inst|mem_ahb_hwdata [31];
//wire	\macro_inst|mem_ahb_hwdata [3];
//wire	\macro_inst|mem_ahb_hwdata [4];
//wire	\macro_inst|mem_ahb_hwdata [5];
//wire	\macro_inst|mem_ahb_hwdata [6];
//wire	\macro_inst|mem_ahb_hwdata [7];
//wire	\macro_inst|mem_ahb_hwdata [8];
//wire	\macro_inst|mem_ahb_hwdata [9];
wire	\macro_inst|mem_ahb_hwrite ;
wire	[31:0] \macro_inst|slave_ahb_hrdata ;
//wire	\macro_inst|slave_ahb_hrdata [0];
//wire	\macro_inst|slave_ahb_hrdata [10];
//wire	\macro_inst|slave_ahb_hrdata [11];
//wire	\macro_inst|slave_ahb_hrdata [12];
//wire	\macro_inst|slave_ahb_hrdata [13];
//wire	\macro_inst|slave_ahb_hrdata [14];
//wire	\macro_inst|slave_ahb_hrdata [15];
//wire	\macro_inst|slave_ahb_hrdata [16];
//wire	\macro_inst|slave_ahb_hrdata [17];
//wire	\macro_inst|slave_ahb_hrdata [18];
//wire	\macro_inst|slave_ahb_hrdata [19];
//wire	\macro_inst|slave_ahb_hrdata [1];
//wire	\macro_inst|slave_ahb_hrdata [20];
//wire	\macro_inst|slave_ahb_hrdata [21];
//wire	\macro_inst|slave_ahb_hrdata [22];
//wire	\macro_inst|slave_ahb_hrdata [23];
//wire	\macro_inst|slave_ahb_hrdata [24];
//wire	\macro_inst|slave_ahb_hrdata [25];
//wire	\macro_inst|slave_ahb_hrdata [26];
//wire	\macro_inst|slave_ahb_hrdata [27];
//wire	\macro_inst|slave_ahb_hrdata [28];
//wire	\macro_inst|slave_ahb_hrdata [29];
//wire	\macro_inst|slave_ahb_hrdata [2];
//wire	\macro_inst|slave_ahb_hrdata [30];
//wire	\macro_inst|slave_ahb_hrdata [31];
//wire	\macro_inst|slave_ahb_hrdata [3];
//wire	\macro_inst|slave_ahb_hrdata [4];
//wire	\macro_inst|slave_ahb_hrdata [5];
//wire	\macro_inst|slave_ahb_hrdata [6];
//wire	\macro_inst|slave_ahb_hrdata [7];
//wire	\macro_inst|slave_ahb_hrdata [8];
//wire	\macro_inst|slave_ahb_hrdata [9];
wire	\macro_inst|slave_ahb_hreadyout ;
wire	\macro_inst|slave_ahb_hresp ;
wire	pll_clkfb;
wire	sys_clk;
wire	[1:0] sys_ctrl_clkSource;
//wire	sys_ctrl_clkSource[0];
//wire	sys_ctrl_clkSource[1];
wire	sys_ctrl_stop;
wire	sys_gck0;
wire	sys_resetn;

wire vcc;
wire gnd;
assign vcc = 1'b1;
assign gnd = 1'b0;

alta_rio CAN0_TX0_o(
	.padio(CAN0_TX0),
	.datain(gpio8_io_out_data[7]),
	.oe(!gpio8_io_out_en[7]),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam CAN0_TX0_o.coord_x = 20;
defparam CAN0_TX0_o.coord_y = 13;
defparam CAN0_TX0_o.coord_z = 3;
defparam CAN0_TX0_o.IN_ASYNC_MODE = 1'b0;
defparam CAN0_TX0_o.IN_SYNC_MODE = 1'b0;
defparam CAN0_TX0_o.IN_POWERUP = 1'b0;
defparam CAN0_TX0_o.OUT_REG_MODE = 1'b0;
defparam CAN0_TX0_o.OUT_ASYNC_MODE = 1'b0;
defparam CAN0_TX0_o.OUT_SYNC_MODE = 1'b0;
defparam CAN0_TX0_o.OUT_POWERUP = 1'b0;
defparam CAN0_TX0_o.OE_REG_MODE = 1'b0;
defparam CAN0_TX0_o.OE_ASYNC_MODE = 1'b0;
defparam CAN0_TX0_o.OE_SYNC_MODE = 1'b0;
defparam CAN0_TX0_o.OE_POWERUP = 1'b0;
defparam CAN0_TX0_o.CFG_TRI_INPUT = 1'b0;
defparam CAN0_TX0_o.CFG_INPUT_EN = 1'b0;
defparam CAN0_TX0_o.CFG_PULL_UP = 1'b0;
defparam CAN0_TX0_o.CFG_SLR = 1'b0;
defparam CAN0_TX0_o.CFG_OPEN_DRAIN = 1'b0;
defparam CAN0_TX0_o.CFG_PDRCTRL = 4'b0100;
defparam CAN0_TX0_o.CFG_KEEP = 2'b00;
defparam CAN0_TX0_o.CFG_LVDS_OUT_EN = 1'b0;
defparam CAN0_TX0_o.CFG_LVDS_SEL_CUA = 2'b00;
defparam CAN0_TX0_o.CFG_LVDS_IREF = 10'b0110000000;
defparam CAN0_TX0_o.CFG_LVDS_IN_EN = 1'b0;
defparam CAN0_TX0_o.DPCLK_DELAY = 4'b0000;
defparam CAN0_TX0_o.OUT_DELAY = 1'b0;
defparam CAN0_TX0_o.IN_DATA_DELAY = 3'b000;
defparam CAN0_TX0_o.IN_REG_DELAY = 3'b000;

alta_rio PIN_HSE_i(
	.padio(PIN_HSE),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(PIN_HSE_i_o),
	.regout());
defparam PIN_HSE_i.coord_x = 22;
defparam PIN_HSE_i.coord_y = 4;
defparam PIN_HSE_i.coord_z = 1;
defparam PIN_HSE_i.IN_ASYNC_MODE = 1'b0;
defparam PIN_HSE_i.IN_SYNC_MODE = 1'b0;
defparam PIN_HSE_i.IN_POWERUP = 1'b0;
defparam PIN_HSE_i.OUT_REG_MODE = 1'b0;
defparam PIN_HSE_i.OUT_ASYNC_MODE = 1'b0;
defparam PIN_HSE_i.OUT_SYNC_MODE = 1'b0;
defparam PIN_HSE_i.OUT_POWERUP = 1'b0;
defparam PIN_HSE_i.OE_REG_MODE = 1'b0;
defparam PIN_HSE_i.OE_ASYNC_MODE = 1'b0;
defparam PIN_HSE_i.OE_SYNC_MODE = 1'b0;
defparam PIN_HSE_i.OE_POWERUP = 1'b0;
defparam PIN_HSE_i.CFG_TRI_INPUT = 1'b0;
defparam PIN_HSE_i.CFG_PULL_UP = 1'b0;
defparam PIN_HSE_i.CFG_SLR = 1'b0;
defparam PIN_HSE_i.CFG_OPEN_DRAIN = 1'b0;
defparam PIN_HSE_i.CFG_PDRCTRL = 4'b0010;
defparam PIN_HSE_i.CFG_KEEP = 2'b00;
defparam PIN_HSE_i.CFG_LVDS_OUT_EN = 1'b0;
defparam PIN_HSE_i.CFG_LVDS_SEL_CUA = 2'b00;
defparam PIN_HSE_i.CFG_LVDS_IREF = 10'b0110000000;
defparam PIN_HSE_i.CFG_LVDS_IN_EN = 1'b0;
defparam PIN_HSE_i.DPCLK_DELAY = 4'b0000;
defparam PIN_HSE_i.OUT_DELAY = 1'b0;
defparam PIN_HSE_i.IN_DATA_DELAY = 3'b000;
defparam PIN_HSE_i.IN_REG_DELAY = 3'b000;

alta_rio PIN_HSI_i(
	.padio(PIN_HSI),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(PIN_HSI_i_o),
	.regout());
defparam PIN_HSI_i.coord_x = 22;
defparam PIN_HSI_i.coord_y = 4;
defparam PIN_HSI_i.coord_z = 0;
defparam PIN_HSI_i.IN_ASYNC_MODE = 1'b0;
defparam PIN_HSI_i.IN_SYNC_MODE = 1'b0;
defparam PIN_HSI_i.IN_POWERUP = 1'b0;
defparam PIN_HSI_i.OUT_REG_MODE = 1'b0;
defparam PIN_HSI_i.OUT_ASYNC_MODE = 1'b0;
defparam PIN_HSI_i.OUT_SYNC_MODE = 1'b0;
defparam PIN_HSI_i.OUT_POWERUP = 1'b0;
defparam PIN_HSI_i.OE_REG_MODE = 1'b0;
defparam PIN_HSI_i.OE_ASYNC_MODE = 1'b0;
defparam PIN_HSI_i.OE_SYNC_MODE = 1'b0;
defparam PIN_HSI_i.OE_POWERUP = 1'b0;
defparam PIN_HSI_i.CFG_TRI_INPUT = 1'b0;
defparam PIN_HSI_i.CFG_PULL_UP = 1'b0;
defparam PIN_HSI_i.CFG_SLR = 1'b0;
defparam PIN_HSI_i.CFG_OPEN_DRAIN = 1'b0;
defparam PIN_HSI_i.CFG_PDRCTRL = 4'b0010;
defparam PIN_HSI_i.CFG_KEEP = 2'b00;
defparam PIN_HSI_i.CFG_LVDS_OUT_EN = 1'b0;
defparam PIN_HSI_i.CFG_LVDS_SEL_CUA = 2'b00;
defparam PIN_HSI_i.CFG_LVDS_IREF = 10'b0110000000;
defparam PIN_HSI_i.CFG_LVDS_IN_EN = 1'b0;
defparam PIN_HSI_i.DPCLK_DELAY = 4'b0000;
defparam PIN_HSI_i.OUT_DELAY = 1'b0;
defparam PIN_HSI_i.IN_DATA_DELAY = 3'b000;
defparam PIN_HSI_i.IN_REG_DELAY = 3'b000;

alta_rio PIN_OSC_i(
	.padio(PIN_OSC),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(PIN_OSC_i_o),
	.regout());
defparam PIN_OSC_i.coord_x = 22;
defparam PIN_OSC_i.coord_y = 4;
defparam PIN_OSC_i.coord_z = 2;
defparam PIN_OSC_i.IN_ASYNC_MODE = 1'b0;
defparam PIN_OSC_i.IN_SYNC_MODE = 1'b0;
defparam PIN_OSC_i.IN_POWERUP = 1'b0;
defparam PIN_OSC_i.OUT_REG_MODE = 1'b0;
defparam PIN_OSC_i.OUT_ASYNC_MODE = 1'b0;
defparam PIN_OSC_i.OUT_SYNC_MODE = 1'b0;
defparam PIN_OSC_i.OUT_POWERUP = 1'b0;
defparam PIN_OSC_i.OE_REG_MODE = 1'b0;
defparam PIN_OSC_i.OE_ASYNC_MODE = 1'b0;
defparam PIN_OSC_i.OE_SYNC_MODE = 1'b0;
defparam PIN_OSC_i.OE_POWERUP = 1'b0;
defparam PIN_OSC_i.CFG_TRI_INPUT = 1'b0;
defparam PIN_OSC_i.CFG_PULL_UP = 1'b0;
defparam PIN_OSC_i.CFG_SLR = 1'b0;
defparam PIN_OSC_i.CFG_OPEN_DRAIN = 1'b0;
defparam PIN_OSC_i.CFG_PDRCTRL = 4'b0010;
defparam PIN_OSC_i.CFG_KEEP = 2'b00;
defparam PIN_OSC_i.CFG_LVDS_OUT_EN = 1'b0;
defparam PIN_OSC_i.CFG_LVDS_SEL_CUA = 2'b00;
defparam PIN_OSC_i.CFG_LVDS_IREF = 10'b0110000000;
defparam PIN_OSC_i.CFG_LVDS_IN_EN = 1'b0;
defparam PIN_OSC_i.DPCLK_DELAY = 4'b0000;
defparam PIN_OSC_i.OUT_DELAY = 1'b0;
defparam PIN_OSC_i.IN_DATA_DELAY = 3'b000;
defparam PIN_OSC_i.IN_REG_DELAY = 3'b000;

alta_rio SPI0_CSN_o(
	.padio(SPI0_CSN),
	.datain(gpio4_io_out_data[6]),
	.oe(gpio4_io_out_en[6]),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam SPI0_CSN_o.coord_x = 0;
defparam SPI0_CSN_o.coord_y = 1;
defparam SPI0_CSN_o.coord_z = 2;
defparam SPI0_CSN_o.IN_ASYNC_MODE = 1'b0;
defparam SPI0_CSN_o.IN_SYNC_MODE = 1'b0;
defparam SPI0_CSN_o.IN_POWERUP = 1'b0;
defparam SPI0_CSN_o.OUT_REG_MODE = 1'b0;
defparam SPI0_CSN_o.OUT_ASYNC_MODE = 1'b0;
defparam SPI0_CSN_o.OUT_SYNC_MODE = 1'b0;
defparam SPI0_CSN_o.OUT_POWERUP = 1'b0;
defparam SPI0_CSN_o.OE_REG_MODE = 1'b0;
defparam SPI0_CSN_o.OE_ASYNC_MODE = 1'b0;
defparam SPI0_CSN_o.OE_SYNC_MODE = 1'b0;
defparam SPI0_CSN_o.OE_POWERUP = 1'b0;
defparam SPI0_CSN_o.CFG_TRI_INPUT = 1'b0;
defparam SPI0_CSN_o.CFG_INPUT_EN = 1'b0;
defparam SPI0_CSN_o.CFG_PULL_UP = 1'b0;
defparam SPI0_CSN_o.CFG_SLR = 1'b0;
defparam SPI0_CSN_o.CFG_OPEN_DRAIN = 1'b0;
defparam SPI0_CSN_o.CFG_PDRCTRL = 4'b0100;
defparam SPI0_CSN_o.CFG_KEEP = 2'b00;
defparam SPI0_CSN_o.CFG_LVDS_OUT_EN = 1'b0;
defparam SPI0_CSN_o.CFG_LVDS_SEL_CUA = 2'b00;
defparam SPI0_CSN_o.CFG_LVDS_IREF = 10'b0110000000;
defparam SPI0_CSN_o.CFG_LVDS_IN_EN = 1'b0;
defparam SPI0_CSN_o.DPCLK_DELAY = 4'b0000;
defparam SPI0_CSN_o.OUT_DELAY = 1'b0;
defparam SPI0_CSN_o.IN_DATA_DELAY = 3'b000;
defparam SPI0_CSN_o.IN_REG_DELAY = 3'b000;

alta_rio SPI0_SCK_o(
	.padio(SPI0_SCK),
	.datain(gpio4_io_out_data[5]),
	.oe(gpio4_io_out_en[5]),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam SPI0_SCK_o.coord_x = 0;
defparam SPI0_SCK_o.coord_y = 4;
defparam SPI0_SCK_o.coord_z = 3;
defparam SPI0_SCK_o.IN_ASYNC_MODE = 1'b0;
defparam SPI0_SCK_o.IN_SYNC_MODE = 1'b0;
defparam SPI0_SCK_o.IN_POWERUP = 1'b0;
defparam SPI0_SCK_o.OUT_REG_MODE = 1'b0;
defparam SPI0_SCK_o.OUT_ASYNC_MODE = 1'b0;
defparam SPI0_SCK_o.OUT_SYNC_MODE = 1'b0;
defparam SPI0_SCK_o.OUT_POWERUP = 1'b0;
defparam SPI0_SCK_o.OE_REG_MODE = 1'b0;
defparam SPI0_SCK_o.OE_ASYNC_MODE = 1'b0;
defparam SPI0_SCK_o.OE_SYNC_MODE = 1'b0;
defparam SPI0_SCK_o.OE_POWERUP = 1'b0;
defparam SPI0_SCK_o.CFG_TRI_INPUT = 1'b0;
defparam SPI0_SCK_o.CFG_INPUT_EN = 1'b0;
defparam SPI0_SCK_o.CFG_PULL_UP = 1'b0;
defparam SPI0_SCK_o.CFG_SLR = 1'b0;
defparam SPI0_SCK_o.CFG_OPEN_DRAIN = 1'b0;
defparam SPI0_SCK_o.CFG_PDRCTRL = 4'b0100;
defparam SPI0_SCK_o.CFG_KEEP = 2'b00;
defparam SPI0_SCK_o.CFG_LVDS_OUT_EN = 1'b0;
defparam SPI0_SCK_o.CFG_LVDS_SEL_CUA = 2'b00;
defparam SPI0_SCK_o.CFG_LVDS_IREF = 10'b0110000000;
defparam SPI0_SCK_o.CFG_LVDS_IN_EN = 1'b0;
defparam SPI0_SCK_o.DPCLK_DELAY = 4'b0000;
defparam SPI0_SCK_o.OUT_DELAY = 1'b0;
defparam SPI0_SCK_o.IN_DATA_DELAY = 3'b000;
defparam SPI0_SCK_o.IN_REG_DELAY = 3'b000;

alta_rio UART0_UARTTXD_o(
	.padio(UART0_UARTTXD),
	.datain(gpio7_io_out_data[6]),
	.oe(gpio7_io_out_en[6]),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam UART0_UARTTXD_o.coord_x = 17;
defparam UART0_UARTTXD_o.coord_y = 13;
defparam UART0_UARTTXD_o.coord_z = 2;
defparam UART0_UARTTXD_o.IN_ASYNC_MODE = 1'b0;
defparam UART0_UARTTXD_o.IN_SYNC_MODE = 1'b0;
defparam UART0_UARTTXD_o.IN_POWERUP = 1'b0;
defparam UART0_UARTTXD_o.OUT_REG_MODE = 1'b0;
defparam UART0_UARTTXD_o.OUT_ASYNC_MODE = 1'b0;
defparam UART0_UARTTXD_o.OUT_SYNC_MODE = 1'b0;
defparam UART0_UARTTXD_o.OUT_POWERUP = 1'b0;
defparam UART0_UARTTXD_o.OE_REG_MODE = 1'b0;
defparam UART0_UARTTXD_o.OE_ASYNC_MODE = 1'b0;
defparam UART0_UARTTXD_o.OE_SYNC_MODE = 1'b0;
defparam UART0_UARTTXD_o.OE_POWERUP = 1'b0;
defparam UART0_UARTTXD_o.CFG_TRI_INPUT = 1'b0;
defparam UART0_UARTTXD_o.CFG_INPUT_EN = 1'b0;
defparam UART0_UARTTXD_o.CFG_PULL_UP = 1'b0;
defparam UART0_UARTTXD_o.CFG_SLR = 1'b0;
defparam UART0_UARTTXD_o.CFG_OPEN_DRAIN = 1'b0;
defparam UART0_UARTTXD_o.CFG_PDRCTRL = 4'b0100;
defparam UART0_UARTTXD_o.CFG_KEEP = 2'b00;
defparam UART0_UARTTXD_o.CFG_LVDS_OUT_EN = 1'b0;
defparam UART0_UARTTXD_o.CFG_LVDS_SEL_CUA = 2'b00;
defparam UART0_UARTTXD_o.CFG_LVDS_IREF = 10'b0110000000;
defparam UART0_UARTTXD_o.CFG_LVDS_IN_EN = 1'b0;
defparam UART0_UARTTXD_o.DPCLK_DELAY = 4'b0000;
defparam UART0_UARTTXD_o.OUT_DELAY = 1'b0;
defparam UART0_UARTTXD_o.IN_DATA_DELAY = 3'b000;
defparam UART0_UARTTXD_o.IN_REG_DELAY = 3'b000;

alta_io_gclk gclksw_gclk(
	.inclk(sys_gck0),
	.outclk(bus_clk));
defparam gclksw_gclk.coord_x = 22;
defparam gclksw_gclk.coord_y = 4;
defparam gclksw_gclk.coord_z = 5;

alta_gclkgen gclksw_gen(
	.clkin(sys_clk),
	.ena(vcc),
	.clkout(sys_gck0));
defparam gclksw_gen.coord_x = 22;
defparam gclksw_gen.coord_y = 4;
defparam gclksw_gen.coord_z = 5;
defparam gclksw_gen.ENA_REG_MODE = 1'b0;

alta_gclksw gclksw_inst(
	.resetn(sys_resetn),
	.clkin0(PIN_HSI_i_o),
	.clkin1(PIN_HSE_i_o),
	.clkin2(PLL_CLKOUT[0]),
	.clkin3(),
	.select({sys_ctrl_clkSource[1], sys_ctrl_clkSource[0]}),
	.clkout(sys_clk));
defparam gclksw_inst.coord_x = 22;
defparam gclksw_inst.coord_y = 4;
defparam gclksw_inst.coord_z = 0;

alta_rio gpio0_io_in_o_0(
	.padio(SPI0_SI_IO0),
	.datain(gpio0_io_out_data[0]),
	.oe(gpio0_io_out_en[0]),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(gpio0_io_in[0]),
	.regout());
defparam gpio0_io_in_o_0.coord_x = 0;
defparam gpio0_io_in_o_0.coord_y = 2;
defparam gpio0_io_in_o_0.coord_z = 4;
defparam gpio0_io_in_o_0.IN_ASYNC_MODE = 1'b0;
defparam gpio0_io_in_o_0.IN_SYNC_MODE = 1'b0;
defparam gpio0_io_in_o_0.IN_POWERUP = 1'b0;
defparam gpio0_io_in_o_0.OUT_REG_MODE = 1'b0;
defparam gpio0_io_in_o_0.OUT_ASYNC_MODE = 1'b0;
defparam gpio0_io_in_o_0.OUT_SYNC_MODE = 1'b0;
defparam gpio0_io_in_o_0.OUT_POWERUP = 1'b0;
defparam gpio0_io_in_o_0.OE_REG_MODE = 1'b0;
defparam gpio0_io_in_o_0.OE_ASYNC_MODE = 1'b0;
defparam gpio0_io_in_o_0.OE_SYNC_MODE = 1'b0;
defparam gpio0_io_in_o_0.OE_POWERUP = 1'b0;
defparam gpio0_io_in_o_0.CFG_TRI_INPUT = 1'b0;
defparam gpio0_io_in_o_0.CFG_INPUT_EN = 1'b1;
defparam gpio0_io_in_o_0.CFG_PULL_UP = 1'b0;
defparam gpio0_io_in_o_0.CFG_SLR = 1'b0;
defparam gpio0_io_in_o_0.CFG_OPEN_DRAIN = 1'b0;
defparam gpio0_io_in_o_0.CFG_PDRCTRL = 4'b0100;
defparam gpio0_io_in_o_0.CFG_KEEP = 2'b00;
defparam gpio0_io_in_o_0.CFG_LVDS_OUT_EN = 1'b0;
defparam gpio0_io_in_o_0.CFG_LVDS_SEL_CUA = 2'b00;
defparam gpio0_io_in_o_0.CFG_LVDS_IREF = 10'b0110000000;
defparam gpio0_io_in_o_0.CFG_LVDS_IN_EN = 1'b0;
defparam gpio0_io_in_o_0.DPCLK_DELAY = 4'b0000;
defparam gpio0_io_in_o_0.OUT_DELAY = 1'b0;
defparam gpio0_io_in_o_0.IN_DATA_DELAY = 3'b000;
defparam gpio0_io_in_o_0.IN_REG_DELAY = 3'b000;

alta_rio gpio4_io_in_o_4(
	.padio(GPIO4_4),
	.datain(gpio4_io_out_data[4]),
	.oe(gpio4_io_out_en[4]),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(gpio4_io_in[4]),
	.regout());
defparam gpio4_io_in_o_4.coord_x = 18;
defparam gpio4_io_in_o_4.coord_y = 0;
defparam gpio4_io_in_o_4.coord_z = 1;
defparam gpio4_io_in_o_4.IN_ASYNC_MODE = 1'b0;
defparam gpio4_io_in_o_4.IN_SYNC_MODE = 1'b0;
defparam gpio4_io_in_o_4.IN_POWERUP = 1'b0;
defparam gpio4_io_in_o_4.OUT_REG_MODE = 1'b0;
defparam gpio4_io_in_o_4.OUT_ASYNC_MODE = 1'b0;
defparam gpio4_io_in_o_4.OUT_SYNC_MODE = 1'b0;
defparam gpio4_io_in_o_4.OUT_POWERUP = 1'b0;
defparam gpio4_io_in_o_4.OE_REG_MODE = 1'b0;
defparam gpio4_io_in_o_4.OE_ASYNC_MODE = 1'b0;
defparam gpio4_io_in_o_4.OE_SYNC_MODE = 1'b0;
defparam gpio4_io_in_o_4.OE_POWERUP = 1'b0;
defparam gpio4_io_in_o_4.CFG_TRI_INPUT = 1'b0;
defparam gpio4_io_in_o_4.CFG_INPUT_EN = 1'b1;
defparam gpio4_io_in_o_4.CFG_PULL_UP = 1'b0;
defparam gpio4_io_in_o_4.CFG_SLR = 1'b0;
defparam gpio4_io_in_o_4.CFG_OPEN_DRAIN = 1'b0;
defparam gpio4_io_in_o_4.CFG_PDRCTRL = 4'b0100;
defparam gpio4_io_in_o_4.CFG_KEEP = 2'b00;
defparam gpio4_io_in_o_4.CFG_LVDS_OUT_EN = 1'b0;
defparam gpio4_io_in_o_4.CFG_LVDS_SEL_CUA = 2'b00;
defparam gpio4_io_in_o_4.CFG_LVDS_IREF = 10'b0110000000;
defparam gpio4_io_in_o_4.CFG_LVDS_IN_EN = 1'b0;
defparam gpio4_io_in_o_4.DPCLK_DELAY = 4'b0000;
defparam gpio4_io_in_o_4.OUT_DELAY = 1'b0;
defparam gpio4_io_in_o_4.IN_DATA_DELAY = 3'b000;
defparam gpio4_io_in_o_4.IN_REG_DELAY = 3'b000;

alta_rio gpio5_io_in_o_0(
	.padio(GPIO5_0),
	.datain(gpio5_io_out_data[0]),
	.oe(gpio5_io_out_en[0]),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(gpio5_io_in[0]),
	.regout());
defparam gpio5_io_in_o_0.coord_x = 19;
defparam gpio5_io_in_o_0.coord_y = 0;
defparam gpio5_io_in_o_0.coord_z = 1;
defparam gpio5_io_in_o_0.IN_ASYNC_MODE = 1'b0;
defparam gpio5_io_in_o_0.IN_SYNC_MODE = 1'b0;
defparam gpio5_io_in_o_0.IN_POWERUP = 1'b0;
defparam gpio5_io_in_o_0.OUT_REG_MODE = 1'b0;
defparam gpio5_io_in_o_0.OUT_ASYNC_MODE = 1'b0;
defparam gpio5_io_in_o_0.OUT_SYNC_MODE = 1'b0;
defparam gpio5_io_in_o_0.OUT_POWERUP = 1'b0;
defparam gpio5_io_in_o_0.OE_REG_MODE = 1'b0;
defparam gpio5_io_in_o_0.OE_ASYNC_MODE = 1'b0;
defparam gpio5_io_in_o_0.OE_SYNC_MODE = 1'b0;
defparam gpio5_io_in_o_0.OE_POWERUP = 1'b0;
defparam gpio5_io_in_o_0.CFG_TRI_INPUT = 1'b0;
defparam gpio5_io_in_o_0.CFG_INPUT_EN = 1'b1;
defparam gpio5_io_in_o_0.CFG_PULL_UP = 1'b0;
defparam gpio5_io_in_o_0.CFG_SLR = 1'b0;
defparam gpio5_io_in_o_0.CFG_OPEN_DRAIN = 1'b0;
defparam gpio5_io_in_o_0.CFG_PDRCTRL = 4'b0100;
defparam gpio5_io_in_o_0.CFG_KEEP = 2'b00;
defparam gpio5_io_in_o_0.CFG_LVDS_OUT_EN = 1'b0;
defparam gpio5_io_in_o_0.CFG_LVDS_SEL_CUA = 2'b00;
defparam gpio5_io_in_o_0.CFG_LVDS_IREF = 10'b0110000000;
defparam gpio5_io_in_o_0.CFG_LVDS_IN_EN = 1'b0;
defparam gpio5_io_in_o_0.DPCLK_DELAY = 4'b0000;
defparam gpio5_io_in_o_0.OUT_DELAY = 1'b0;
defparam gpio5_io_in_o_0.IN_DATA_DELAY = 3'b000;
defparam gpio5_io_in_o_0.IN_REG_DELAY = 3'b000;

alta_rio gpio5_io_in_o_1(
	.padio(GPIO5_1),
	.datain(gpio5_io_out_data[1]),
	.oe(gpio5_io_out_en[1]),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(gpio5_io_in[1]),
	.regout());
defparam gpio5_io_in_o_1.coord_x = 0;
defparam gpio5_io_in_o_1.coord_y = 2;
defparam gpio5_io_in_o_1.coord_z = 5;
defparam gpio5_io_in_o_1.IN_ASYNC_MODE = 1'b0;
defparam gpio5_io_in_o_1.IN_SYNC_MODE = 1'b0;
defparam gpio5_io_in_o_1.IN_POWERUP = 1'b0;
defparam gpio5_io_in_o_1.OUT_REG_MODE = 1'b0;
defparam gpio5_io_in_o_1.OUT_ASYNC_MODE = 1'b0;
defparam gpio5_io_in_o_1.OUT_SYNC_MODE = 1'b0;
defparam gpio5_io_in_o_1.OUT_POWERUP = 1'b0;
defparam gpio5_io_in_o_1.OE_REG_MODE = 1'b0;
defparam gpio5_io_in_o_1.OE_ASYNC_MODE = 1'b0;
defparam gpio5_io_in_o_1.OE_SYNC_MODE = 1'b0;
defparam gpio5_io_in_o_1.OE_POWERUP = 1'b0;
defparam gpio5_io_in_o_1.CFG_TRI_INPUT = 1'b0;
defparam gpio5_io_in_o_1.CFG_INPUT_EN = 1'b1;
defparam gpio5_io_in_o_1.CFG_PULL_UP = 1'b0;
defparam gpio5_io_in_o_1.CFG_SLR = 1'b0;
defparam gpio5_io_in_o_1.CFG_OPEN_DRAIN = 1'b0;
defparam gpio5_io_in_o_1.CFG_PDRCTRL = 4'b0100;
defparam gpio5_io_in_o_1.CFG_KEEP = 2'b00;
defparam gpio5_io_in_o_1.CFG_LVDS_OUT_EN = 1'b0;
defparam gpio5_io_in_o_1.CFG_LVDS_SEL_CUA = 2'b00;
defparam gpio5_io_in_o_1.CFG_LVDS_IREF = 10'b0110000000;
defparam gpio5_io_in_o_1.CFG_LVDS_IN_EN = 1'b0;
defparam gpio5_io_in_o_1.DPCLK_DELAY = 4'b0000;
defparam gpio5_io_in_o_1.OUT_DELAY = 1'b0;
defparam gpio5_io_in_o_1.IN_DATA_DELAY = 3'b000;
defparam gpio5_io_in_o_1.IN_REG_DELAY = 3'b000;

alta_rio gpio5_io_in_o_2(
	.padio(GPIO5_2),
	.datain(gpio5_io_out_data[2]),
	.oe(gpio5_io_out_en[2]),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(gpio5_io_in[2]),
	.regout());
defparam gpio5_io_in_o_2.coord_x = 0;
defparam gpio5_io_in_o_2.coord_y = 1;
defparam gpio5_io_in_o_2.coord_z = 0;
defparam gpio5_io_in_o_2.IN_ASYNC_MODE = 1'b0;
defparam gpio5_io_in_o_2.IN_SYNC_MODE = 1'b0;
defparam gpio5_io_in_o_2.IN_POWERUP = 1'b0;
defparam gpio5_io_in_o_2.OUT_REG_MODE = 1'b0;
defparam gpio5_io_in_o_2.OUT_ASYNC_MODE = 1'b0;
defparam gpio5_io_in_o_2.OUT_SYNC_MODE = 1'b0;
defparam gpio5_io_in_o_2.OUT_POWERUP = 1'b0;
defparam gpio5_io_in_o_2.OE_REG_MODE = 1'b0;
defparam gpio5_io_in_o_2.OE_ASYNC_MODE = 1'b0;
defparam gpio5_io_in_o_2.OE_SYNC_MODE = 1'b0;
defparam gpio5_io_in_o_2.OE_POWERUP = 1'b0;
defparam gpio5_io_in_o_2.CFG_TRI_INPUT = 1'b0;
defparam gpio5_io_in_o_2.CFG_INPUT_EN = 1'b1;
defparam gpio5_io_in_o_2.CFG_PULL_UP = 1'b0;
defparam gpio5_io_in_o_2.CFG_SLR = 1'b0;
defparam gpio5_io_in_o_2.CFG_OPEN_DRAIN = 1'b0;
defparam gpio5_io_in_o_2.CFG_PDRCTRL = 4'b0100;
defparam gpio5_io_in_o_2.CFG_KEEP = 2'b00;
defparam gpio5_io_in_o_2.CFG_LVDS_OUT_EN = 1'b0;
defparam gpio5_io_in_o_2.CFG_LVDS_SEL_CUA = 2'b00;
defparam gpio5_io_in_o_2.CFG_LVDS_IREF = 10'b0110000000;
defparam gpio5_io_in_o_2.CFG_LVDS_IN_EN = 1'b0;
defparam gpio5_io_in_o_2.DPCLK_DELAY = 4'b0000;
defparam gpio5_io_in_o_2.OUT_DELAY = 1'b0;
defparam gpio5_io_in_o_2.IN_DATA_DELAY = 3'b000;
defparam gpio5_io_in_o_2.IN_REG_DELAY = 3'b000;

alta_rio gpio5_io_in_o_3(
	.padio(GPIO5_3),
	.datain(gpio5_io_out_data[3]),
	.oe(gpio5_io_out_en[3]),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(gpio5_io_in[3]),
	.regout());
defparam gpio5_io_in_o_3.coord_x = 0;
defparam gpio5_io_in_o_3.coord_y = 1;
defparam gpio5_io_in_o_3.coord_z = 3;
defparam gpio5_io_in_o_3.IN_ASYNC_MODE = 1'b0;
defparam gpio5_io_in_o_3.IN_SYNC_MODE = 1'b0;
defparam gpio5_io_in_o_3.IN_POWERUP = 1'b0;
defparam gpio5_io_in_o_3.OUT_REG_MODE = 1'b0;
defparam gpio5_io_in_o_3.OUT_ASYNC_MODE = 1'b0;
defparam gpio5_io_in_o_3.OUT_SYNC_MODE = 1'b0;
defparam gpio5_io_in_o_3.OUT_POWERUP = 1'b0;
defparam gpio5_io_in_o_3.OE_REG_MODE = 1'b0;
defparam gpio5_io_in_o_3.OE_ASYNC_MODE = 1'b0;
defparam gpio5_io_in_o_3.OE_SYNC_MODE = 1'b0;
defparam gpio5_io_in_o_3.OE_POWERUP = 1'b0;
defparam gpio5_io_in_o_3.CFG_TRI_INPUT = 1'b0;
defparam gpio5_io_in_o_3.CFG_INPUT_EN = 1'b1;
defparam gpio5_io_in_o_3.CFG_PULL_UP = 1'b0;
defparam gpio5_io_in_o_3.CFG_SLR = 1'b0;
defparam gpio5_io_in_o_3.CFG_OPEN_DRAIN = 1'b0;
defparam gpio5_io_in_o_3.CFG_PDRCTRL = 4'b0100;
defparam gpio5_io_in_o_3.CFG_KEEP = 2'b00;
defparam gpio5_io_in_o_3.CFG_LVDS_OUT_EN = 1'b0;
defparam gpio5_io_in_o_3.CFG_LVDS_SEL_CUA = 2'b00;
defparam gpio5_io_in_o_3.CFG_LVDS_IREF = 10'b0110000000;
defparam gpio5_io_in_o_3.CFG_LVDS_IN_EN = 1'b0;
defparam gpio5_io_in_o_3.DPCLK_DELAY = 4'b0000;
defparam gpio5_io_in_o_3.OUT_DELAY = 1'b0;
defparam gpio5_io_in_o_3.IN_DATA_DELAY = 3'b000;
defparam gpio5_io_in_o_3.IN_REG_DELAY = 3'b000;

alta_rio gpio6_io_in_o_1(
	.padio(UART0_UARTRXD),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(gpio6_io_in[1]),
	.regout());
defparam gpio6_io_in_o_1.coord_x = 14;
defparam gpio6_io_in_o_1.coord_y = 13;
defparam gpio6_io_in_o_1.coord_z = 2;
defparam gpio6_io_in_o_1.IN_ASYNC_MODE = 1'b0;
defparam gpio6_io_in_o_1.IN_SYNC_MODE = 1'b0;
defparam gpio6_io_in_o_1.IN_POWERUP = 1'b0;
defparam gpio6_io_in_o_1.OUT_REG_MODE = 1'b0;
defparam gpio6_io_in_o_1.OUT_ASYNC_MODE = 1'b0;
defparam gpio6_io_in_o_1.OUT_SYNC_MODE = 1'b0;
defparam gpio6_io_in_o_1.OUT_POWERUP = 1'b0;
defparam gpio6_io_in_o_1.OE_REG_MODE = 1'b0;
defparam gpio6_io_in_o_1.OE_ASYNC_MODE = 1'b0;
defparam gpio6_io_in_o_1.OE_SYNC_MODE = 1'b0;
defparam gpio6_io_in_o_1.OE_POWERUP = 1'b0;
defparam gpio6_io_in_o_1.CFG_TRI_INPUT = 1'b0;
defparam gpio6_io_in_o_1.CFG_INPUT_EN = 1'b1;
defparam gpio6_io_in_o_1.CFG_PULL_UP = 1'b0;
defparam gpio6_io_in_o_1.CFG_SLR = 1'b0;
defparam gpio6_io_in_o_1.CFG_OPEN_DRAIN = 1'b0;
defparam gpio6_io_in_o_1.CFG_PDRCTRL = 4'b0100;
defparam gpio6_io_in_o_1.CFG_KEEP = 2'b00;
defparam gpio6_io_in_o_1.CFG_LVDS_OUT_EN = 1'b0;
defparam gpio6_io_in_o_1.CFG_LVDS_SEL_CUA = 2'b00;
defparam gpio6_io_in_o_1.CFG_LVDS_IREF = 10'b0110000000;
defparam gpio6_io_in_o_1.CFG_LVDS_IN_EN = 1'b0;
defparam gpio6_io_in_o_1.DPCLK_DELAY = 4'b0000;
defparam gpio6_io_in_o_1.OUT_DELAY = 1'b0;
defparam gpio6_io_in_o_1.IN_DATA_DELAY = 3'b000;
defparam gpio6_io_in_o_1.IN_REG_DELAY = 3'b000;

alta_rio gpio7_io_in_o_3(
	.padio(CAN0_RX0),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(gpio7_io_in[3]),
	.regout());
defparam gpio7_io_in_o_3.coord_x = 19;
defparam gpio7_io_in_o_3.coord_y = 13;
defparam gpio7_io_in_o_3.coord_z = 3;
defparam gpio7_io_in_o_3.IN_ASYNC_MODE = 1'b0;
defparam gpio7_io_in_o_3.IN_SYNC_MODE = 1'b0;
defparam gpio7_io_in_o_3.IN_POWERUP = 1'b0;
defparam gpio7_io_in_o_3.OUT_REG_MODE = 1'b0;
defparam gpio7_io_in_o_3.OUT_ASYNC_MODE = 1'b0;
defparam gpio7_io_in_o_3.OUT_SYNC_MODE = 1'b0;
defparam gpio7_io_in_o_3.OUT_POWERUP = 1'b0;
defparam gpio7_io_in_o_3.OE_REG_MODE = 1'b0;
defparam gpio7_io_in_o_3.OE_ASYNC_MODE = 1'b0;
defparam gpio7_io_in_o_3.OE_SYNC_MODE = 1'b0;
defparam gpio7_io_in_o_3.OE_POWERUP = 1'b0;
defparam gpio7_io_in_o_3.CFG_TRI_INPUT = 1'b0;
defparam gpio7_io_in_o_3.CFG_INPUT_EN = 1'b1;
defparam gpio7_io_in_o_3.CFG_PULL_UP = 1'b0;
defparam gpio7_io_in_o_3.CFG_SLR = 1'b0;
defparam gpio7_io_in_o_3.CFG_OPEN_DRAIN = 1'b0;
defparam gpio7_io_in_o_3.CFG_PDRCTRL = 4'b0100;
defparam gpio7_io_in_o_3.CFG_KEEP = 2'b00;
defparam gpio7_io_in_o_3.CFG_LVDS_OUT_EN = 1'b0;
defparam gpio7_io_in_o_3.CFG_LVDS_SEL_CUA = 2'b00;
defparam gpio7_io_in_o_3.CFG_LVDS_IREF = 10'b0110000000;
defparam gpio7_io_in_o_3.CFG_LVDS_IN_EN = 1'b0;
defparam gpio7_io_in_o_3.DPCLK_DELAY = 4'b0000;
defparam gpio7_io_in_o_3.OUT_DELAY = 1'b0;
defparam gpio7_io_in_o_3.IN_DATA_DELAY = 3'b000;
defparam gpio7_io_in_o_3.IN_REG_DELAY = 3'b000;

alta_pllve pll_inst(
	.clkin(PIN_HSE_i_o),
	.clkfb(pll_clkfb),
	.pfden(vcc),
	.resetn(PLL_ENABLE),
	.phasecounterselect({gnd, gnd, gnd}),
	.phaseupdown(gnd),
	.phasestep(gnd),
	.scanclk(gnd),
	.scanclkena(gnd),
	.scandata(gnd),
	.configupdate(gnd),
	.scandataout(),
	.scandone(),
	.phasedone(),
	.clkout0(PLL_CLKOUT[0]),
	.clkout1(PLL_CLKOUT[1]),
	.clkout2(PLL_CLKOUT[2]),
	.clkout3(PLL_CLKOUT[3]),
	.clkout4(PLL_CLKOUT[4]),
	.clkfbout(pll_clkfb),
	.lock(PLL_LOCK));
defparam pll_inst.coord_x = 22;
defparam pll_inst.coord_y = 5;
defparam pll_inst.coord_z = 0;
defparam pll_inst.CLKIN_HIGH = 8'b00000000;
defparam pll_inst.CLKIN_LOW = 8'b00000000;
defparam pll_inst.CLKIN_TRIM = 1'b0;
defparam pll_inst.CLKIN_BYPASS = 1'b0;
defparam pll_inst.CLKFB_HIGH = 8'b00110001;
defparam pll_inst.CLKFB_LOW = 8'b00110001;
defparam pll_inst.CLKFB_TRIM = 1'b0;
defparam pll_inst.CLKFB_BYPASS = 1'b0;
defparam pll_inst.CLKDIV0_EN = 1'b1;
defparam pll_inst.CLKDIV1_EN = 1'b0;
defparam pll_inst.CLKDIV2_EN = 1'b0;
defparam pll_inst.CLKDIV3_EN = 1'b0;
defparam pll_inst.CLKDIV4_EN = 1'b0;
defparam pll_inst.CLKOUT0_HIGH = 8'b00000000;
defparam pll_inst.CLKOUT0_LOW = 8'b00000000;
defparam pll_inst.CLKOUT0_TRIM = 1'b0;
defparam pll_inst.CLKOUT0_BYPASS = 1'b0;
defparam pll_inst.CLKOUT1_HIGH = 8'b11111111;
defparam pll_inst.CLKOUT1_LOW = 8'b11111111;
defparam pll_inst.CLKOUT1_TRIM = 1'b0;
defparam pll_inst.CLKOUT1_BYPASS = 1'b0;
defparam pll_inst.CLKOUT2_HIGH = 8'b11111111;
defparam pll_inst.CLKOUT2_LOW = 8'b11111111;
defparam pll_inst.CLKOUT2_TRIM = 1'b0;
defparam pll_inst.CLKOUT2_BYPASS = 1'b0;
defparam pll_inst.CLKOUT3_HIGH = 8'b11111111;
defparam pll_inst.CLKOUT3_LOW = 8'b11111111;
defparam pll_inst.CLKOUT3_TRIM = 1'b0;
defparam pll_inst.CLKOUT3_BYPASS = 1'b0;
defparam pll_inst.CLKOUT4_HIGH = 8'b11111111;
defparam pll_inst.CLKOUT4_LOW = 8'b11111111;
defparam pll_inst.CLKOUT4_TRIM = 1'b0;
defparam pll_inst.CLKOUT4_BYPASS = 1'b0;
defparam pll_inst.CLKOUT0_DEL = 8'b00000000;
defparam pll_inst.CLKOUT1_DEL = 8'b00000000;
defparam pll_inst.CLKOUT2_DEL = 8'b00000000;
defparam pll_inst.CLKOUT3_DEL = 8'b00000000;
defparam pll_inst.CLKOUT4_DEL = 8'b00000000;
defparam pll_inst.CLKOUT0_PHASE = 3'b000;
defparam pll_inst.CLKOUT1_PHASE = 3'b000;
defparam pll_inst.CLKOUT2_PHASE = 3'b000;
defparam pll_inst.CLKOUT3_PHASE = 3'b000;
defparam pll_inst.CLKOUT4_PHASE = 3'b000;
defparam pll_inst.CLKFB_DEL = 8'b00000000;
defparam pll_inst.CLKFB_PHASE = 3'b000;
defparam pll_inst.FEEDBACK_MODE = 3'b100;
defparam pll_inst.FBDELAY_VAL = 3'b100;
defparam pll_inst.PLLOUTP_EN = 1'b0;
defparam pll_inst.PLLOUTN_EN = 1'b0;
defparam pll_inst.CLKOUT1_CASCADE = 1'b0;
defparam pll_inst.CLKOUT2_CASCADE = 1'b0;
defparam pll_inst.CLKOUT3_CASCADE = 1'b0;
defparam pll_inst.CLKOUT4_CASCADE = 1'b0;
defparam pll_inst.VCO_POST_DIV = 1'b1;
defparam pll_inst.REG_CTRL = 2'b00;
defparam pll_inst.CP = 3'b100;
defparam pll_inst.RREF = 2'b01;
defparam pll_inst.RVI = 2'b01;
defparam pll_inst.IVCO = 3'b010;
defparam pll_inst.PLL_EN_FLAG = 1'b1;

alta_rv32 rv32(
	.sys_clk(sys_clk),
	.mem_ahb_hready(\macro_inst|mem_ahb_hready ),
	.mem_ahb_hreadyout(vcc),
	.mem_ahb_htrans({\macro_inst|mem_ahb_htrans [1], \macro_inst|mem_ahb_htrans [0]}),
	.mem_ahb_hsize({\macro_inst|mem_ahb_hsize [2], \macro_inst|mem_ahb_hsize [1], \macro_inst|mem_ahb_hsize [0]}),
	.mem_ahb_hburst({\macro_inst|mem_ahb_hburst [2], \macro_inst|mem_ahb_hburst [1], \macro_inst|mem_ahb_hburst [0]}),
	.mem_ahb_hwrite(\macro_inst|mem_ahb_hwrite ),
	.mem_ahb_haddr({\macro_inst|mem_ahb_haddr [31], \macro_inst|mem_ahb_haddr [30], \macro_inst|mem_ahb_haddr [29], \macro_inst|mem_ahb_haddr [28], \macro_inst|mem_ahb_haddr [27], \macro_inst|mem_ahb_haddr [26], \macro_inst|mem_ahb_haddr [25], \macro_inst|mem_ahb_haddr [24], \macro_inst|mem_ahb_haddr [23], \macro_inst|mem_ahb_haddr [22], \macro_inst|mem_ahb_haddr [21], \macro_inst|mem_ahb_haddr [20], \macro_inst|mem_ahb_haddr [19], \macro_inst|mem_ahb_haddr [18], \macro_inst|mem_ahb_haddr [17], \macro_inst|mem_ahb_haddr [16], \macro_inst|mem_ahb_haddr [15], \macro_inst|mem_ahb_haddr [14], \macro_inst|mem_ahb_haddr [13], \macro_inst|mem_ahb_haddr [12], \macro_inst|mem_ahb_haddr [11], \macro_inst|mem_ahb_haddr [10], \macro_inst|mem_ahb_haddr [9], \macro_inst|mem_ahb_haddr [8], \macro_inst|mem_ahb_haddr [7], \macro_inst|mem_ahb_haddr [6], \macro_inst|mem_ahb_haddr [5], \macro_inst|mem_ahb_haddr [4], \macro_inst|mem_ahb_haddr [3], \macro_inst|mem_ahb_haddr [2], \macro_inst|mem_ahb_haddr [1], \macro_inst|mem_ahb_haddr [0]}),
	.mem_ahb_hwdata({\macro_inst|mem_ahb_hwdata [31], \macro_inst|mem_ahb_hwdata [30], \macro_inst|mem_ahb_hwdata [29], \macro_inst|mem_ahb_hwdata [28], \macro_inst|mem_ahb_hwdata [27], \macro_inst|mem_ahb_hwdata [26], \macro_inst|mem_ahb_hwdata [25], \macro_inst|mem_ahb_hwdata [24], \macro_inst|mem_ahb_hwdata [23], \macro_inst|mem_ahb_hwdata [22], \macro_inst|mem_ahb_hwdata [21], \macro_inst|mem_ahb_hwdata [20], \macro_inst|mem_ahb_hwdata [19], \macro_inst|mem_ahb_hwdata [18], \macro_inst|mem_ahb_hwdata [17], \macro_inst|mem_ahb_hwdata [16], \macro_inst|mem_ahb_hwdata [15], \macro_inst|mem_ahb_hwdata [14], \macro_inst|mem_ahb_hwdata [13], \macro_inst|mem_ahb_hwdata [12], \macro_inst|mem_ahb_hwdata [11], \macro_inst|mem_ahb_hwdata [10], \macro_inst|mem_ahb_hwdata [9], \macro_inst|mem_ahb_hwdata [8], \macro_inst|mem_ahb_hwdata [7], \macro_inst|mem_ahb_hwdata [6], \macro_inst|mem_ahb_hwdata [5], \macro_inst|mem_ahb_hwdata [4], \macro_inst|mem_ahb_hwdata [3], \macro_inst|mem_ahb_hwdata [2], \macro_inst|mem_ahb_hwdata [1], \macro_inst|mem_ahb_hwdata [0]}),
	.mem_ahb_hresp(gnd),
	.mem_ahb_hrdata({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz}),
	.slave_ahb_hsel(gnd),
	.slave_ahb_hready(vcc),
	.slave_ahb_hreadyout(\macro_inst|slave_ahb_hreadyout ),
	.slave_ahb_htrans({gnd, gnd}),
	.slave_ahb_hsize({gnd, gnd, gnd}),
	.slave_ahb_hburst({gnd, gnd, gnd}),
	.slave_ahb_hwrite(gnd),
	.slave_ahb_haddr({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz}),
	.slave_ahb_hwdata({1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz, 1'bz}),
	.slave_ahb_hresp(\macro_inst|slave_ahb_hresp ),
	.slave_ahb_hrdata({\macro_inst|slave_ahb_hrdata [31], \macro_inst|slave_ahb_hrdata [30], \macro_inst|slave_ahb_hrdata [29], \macro_inst|slave_ahb_hrdata [28], \macro_inst|slave_ahb_hrdata [27], \macro_inst|slave_ahb_hrdata [26], \macro_inst|slave_ahb_hrdata [25], \macro_inst|slave_ahb_hrdata [24], \macro_inst|slave_ahb_hrdata [23], \macro_inst|slave_ahb_hrdata [22], \macro_inst|slave_ahb_hrdata [21], \macro_inst|slave_ahb_hrdata [20], \macro_inst|slave_ahb_hrdata [19], \macro_inst|slave_ahb_hrdata [18], \macro_inst|slave_ahb_hrdata [17], \macro_inst|slave_ahb_hrdata [16], \macro_inst|slave_ahb_hrdata [15], \macro_inst|slave_ahb_hrdata [14], \macro_inst|slave_ahb_hrdata [13], \macro_inst|slave_ahb_hrdata [12], \macro_inst|slave_ahb_hrdata [11], \macro_inst|slave_ahb_hrdata [10], \macro_inst|slave_ahb_hrdata [9], \macro_inst|slave_ahb_hrdata [8], \macro_inst|slave_ahb_hrdata [7], \macro_inst|slave_ahb_hrdata [6], \macro_inst|slave_ahb_hrdata [5], \macro_inst|slave_ahb_hrdata [4], \macro_inst|slave_ahb_hrdata [3], \macro_inst|slave_ahb_hrdata [2], \macro_inst|slave_ahb_hrdata [1], \macro_inst|slave_ahb_hrdata [0]}),
	.gpio0_io_in({gnd, gnd, gnd, gnd, gnd, gnd, gnd, gpio0_io_in[0]}),
	.gpio0_io_out_data({gpio0_io_out_data[7], gpio0_io_out_data[6], gpio0_io_out_data[5], gpio0_io_out_data[4], gpio0_io_out_data[3], gpio0_io_out_data[2], gpio0_io_out_data[1], gpio0_io_out_data[0]}),
	.gpio0_io_out_en({gpio0_io_out_en[7], gpio0_io_out_en[6], gpio0_io_out_en[5], gpio0_io_out_en[4], gpio0_io_out_en[3], gpio0_io_out_en[2], gpio0_io_out_en[1], gpio0_io_out_en[0]}),
	.gpio1_io_in({gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd}),
	.gpio1_io_out_data({gpio1_io_out_data[7], gpio1_io_out_data[6], gpio1_io_out_data[5], gpio1_io_out_data[4], gpio1_io_out_data[3], gpio1_io_out_data[2], gpio1_io_out_data[1], gpio1_io_out_data[0]}),
	.gpio1_io_out_en({gpio1_io_out_en[7], gpio1_io_out_en[6], gpio1_io_out_en[5], gpio1_io_out_en[4], gpio1_io_out_en[3], gpio1_io_out_en[2], gpio1_io_out_en[1], gpio1_io_out_en[0]}),
	.sys_ctrl_clkSource({sys_ctrl_clkSource[1], sys_ctrl_clkSource[0]}),
	.sys_ctrl_hseEnable(),
	.sys_ctrl_hseBypass(),
	.sys_ctrl_pllEnable(PLL_ENABLE),
	.sys_ctrl_pllReady(PLL_LOCK),
	.sys_ctrl_sleep(),
	.sys_ctrl_stop(sys_ctrl_stop),
	.sys_ctrl_standby(),
	.gpio2_io_in({gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd}),
	.gpio2_io_out_data({gpio2_io_out_data[7], gpio2_io_out_data[6], gpio2_io_out_data[5], gpio2_io_out_data[4], gpio2_io_out_data[3], gpio2_io_out_data[2], gpio2_io_out_data[1], gpio2_io_out_data[0]}),
	.gpio2_io_out_en({gpio2_io_out_en[7], gpio2_io_out_en[6], gpio2_io_out_en[5], gpio2_io_out_en[4], gpio2_io_out_en[3], gpio2_io_out_en[2], gpio2_io_out_en[1], gpio2_io_out_en[0]}),
	.gpio3_io_in({gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd}),
	.gpio3_io_out_data({gpio3_io_out_data[7], gpio3_io_out_data[6], gpio3_io_out_data[5], gpio3_io_out_data[4], gpio3_io_out_data[3], gpio3_io_out_data[2], gpio3_io_out_data[1], gpio3_io_out_data[0]}),
	.gpio3_io_out_en({gpio3_io_out_en[7], gpio3_io_out_en[6], gpio3_io_out_en[5], gpio3_io_out_en[4], gpio3_io_out_en[3], gpio3_io_out_en[2], gpio3_io_out_en[1], gpio3_io_out_en[0]}),
	.gpio4_io_in({gnd, gnd, gnd, gpio4_io_in[4], gnd, gnd, gnd, gnd}),
	.gpio4_io_out_data({gpio4_io_out_data[7], gpio4_io_out_data[6], gpio4_io_out_data[5], gpio4_io_out_data[4], gpio4_io_out_data[3], gpio4_io_out_data[2], gpio4_io_out_data[1], gpio4_io_out_data[0]}),
	.gpio4_io_out_en({gpio4_io_out_en[7], gpio4_io_out_en[6], gpio4_io_out_en[5], gpio4_io_out_en[4], gpio4_io_out_en[3], gpio4_io_out_en[2], gpio4_io_out_en[1], gpio4_io_out_en[0]}),
	.gpio5_io_in({gnd, gnd, gnd, gnd, gpio5_io_in[3], gpio5_io_in[2], gpio5_io_in[1], gpio5_io_in[0]}),
	.gpio5_io_out_data({gpio5_io_out_data[7], gpio5_io_out_data[6], gpio5_io_out_data[5], gpio5_io_out_data[4], gpio5_io_out_data[3], gpio5_io_out_data[2], gpio5_io_out_data[1], gpio5_io_out_data[0]}),
	.gpio5_io_out_en({gpio5_io_out_en[7], gpio5_io_out_en[6], gpio5_io_out_en[5], gpio5_io_out_en[4], gpio5_io_out_en[3], gpio5_io_out_en[2], gpio5_io_out_en[1], gpio5_io_out_en[0]}),
	.gpio6_io_in({gnd, gnd, gnd, gnd, gnd, gnd, gpio6_io_in[1], gnd}),
	.gpio6_io_out_data({gpio6_io_out_data[7], gpio6_io_out_data[6], gpio6_io_out_data[5], gpio6_io_out_data[4], gpio6_io_out_data[3], gpio6_io_out_data[2], gpio6_io_out_data[1], gpio6_io_out_data[0]}),
	.gpio6_io_out_en({gpio6_io_out_en[7], gpio6_io_out_en[6], gpio6_io_out_en[5], gpio6_io_out_en[4], gpio6_io_out_en[3], gpio6_io_out_en[2], gpio6_io_out_en[1], gpio6_io_out_en[0]}),
	.gpio7_io_in({gnd, gnd, gnd, gnd, gpio7_io_in[3], gnd, gnd, gnd}),
	.gpio7_io_out_data({gpio7_io_out_data[7], gpio7_io_out_data[6], gpio7_io_out_data[5], gpio7_io_out_data[4], gpio7_io_out_data[3], gpio7_io_out_data[2], gpio7_io_out_data[1], gpio7_io_out_data[0]}),
	.gpio7_io_out_en({gpio7_io_out_en[7], gpio7_io_out_en[6], gpio7_io_out_en[5], gpio7_io_out_en[4], gpio7_io_out_en[3], gpio7_io_out_en[2], gpio7_io_out_en[1], gpio7_io_out_en[0]}),
	.gpio8_io_in({gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd}),
	.gpio8_io_out_data({gpio8_io_out_data[7], gpio8_io_out_data[6], gpio8_io_out_data[5], gpio8_io_out_data[4], gpio8_io_out_data[3], gpio8_io_out_data[2], gpio8_io_out_data[1], gpio8_io_out_data[0]}),
	.gpio8_io_out_en({gpio8_io_out_en[7], gpio8_io_out_en[6], gpio8_io_out_en[5], gpio8_io_out_en[4], gpio8_io_out_en[3], gpio8_io_out_en[2], gpio8_io_out_en[1], gpio8_io_out_en[0]}),
	.gpio9_io_in({gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd}),
	.gpio9_io_out_data({gpio9_io_out_data[7], gpio9_io_out_data[6], gpio9_io_out_data[5], gpio9_io_out_data[4], gpio9_io_out_data[3], gpio9_io_out_data[2], gpio9_io_out_data[1], gpio9_io_out_data[0]}),
	.gpio9_io_out_en({gpio9_io_out_en[7], gpio9_io_out_en[6], gpio9_io_out_en[5], gpio9_io_out_en[4], gpio9_io_out_en[3], gpio9_io_out_en[2], gpio9_io_out_en[1], gpio9_io_out_en[0]}),
	.ext_resetn(vcc),
	.resetn_out(sys_resetn),
	.dmactive(),
	.swj_JTAGNSW(),
	.swj_JTAGSTATE(),
	.swj_JTAGIR(),
	.ext_int({gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd}),
	.ext_dma_DMACBREQ({gnd, gnd, gnd, gnd}),
	.ext_dma_DMACLBREQ({gnd, gnd, gnd, gnd}),
	.ext_dma_DMACSREQ({gnd, gnd, gnd, gnd}),
	.ext_dma_DMACLSREQ({gnd, gnd, gnd, gnd}),
	.ext_dma_DMACCLR({ext_dma_DMACCLR[3], ext_dma_DMACCLR[2], ext_dma_DMACCLR[1], ext_dma_DMACCLR[0]}),
	.ext_dma_DMACTC({ext_dma_DMACTC[3], ext_dma_DMACTC[2], ext_dma_DMACTC[1], ext_dma_DMACTC[0]}),
	.local_int({gnd, gnd, gnd, gnd}),
	.test_mode({gnd, gnd}),
	.usb0_xcvr_clk(vcc),
	.usb0_id(vcc));
defparam rv32.coord_x = 0;
defparam rv32.coord_y = 5;
defparam rv32.coord_z = 0;

endmodule
