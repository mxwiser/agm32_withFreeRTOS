`timescale 1 ps/ 1 ps

module example_board(
	CAN0_RX0,
	CAN0_TX0,
	GPIO4_4,
	GPIO5_1,
	GPIO5_2,
	GPIO5_3,
	GPTIMER4_CH0,
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
inout	GPIO5_1;
inout	GPIO5_2;
inout	GPIO5_3;
inout	GPTIMER4_CH0;
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
//wire	unknown;
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
wire	SyncLoad_X10001_Y10001_VCC;
wire	SyncLoad_X10004_Y10001_VCC;
wire	SyncReset_X10001_Y10001_GND;
wire	SyncReset_X10003_Y10001_GND;
wire	SyncReset_X10004_Y10001_GND;
wire	SyncReset_X10005_Y10001_GND;
wire	bus_clk;
wire	bus_clk_X10001_Y10001_SIG_VCC;
wire	bus_clk_X10003_Y10001_SIG_VCC;
wire	bus_clk_X10004_Y10001_SIG_VCC;
wire	bus_clk_X10005_Y10001_SIG_VCC;
wire	\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10002_Y10001_SIG_SIG ;
wire	\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10007_Y10001_SIG_SIG ;
wire	\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10001_Y10001_SIG_SIG ;
wire	\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10005_Y10001_SIG_SIG ;
wire	\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10006_Y10001_SIG_SIG ;
wire	\bus_clk__macro_inst|apb_penable_B_Y_X10002_Y10001_SIG_SIG ;
wire	\bus_clk__macro_inst|apb_penable_B_Y_X10006_Y10001_SIG_SIG ;
wire	\bus_clk__macro_inst|bridge|apb_pdone_X10003_Y10001_SIG_SIG ;
wire	\bus_clk__macro_inst|bridge|apb_pdone_X10004_Y10001_SIG_SIG ;
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
wire	[7:0] gpio3_io_in;
//wire	gpio3_io_in[0];
//wire	gpio3_io_in[1];
//wire	gpio3_io_in[2];
//wire	gpio3_io_in[3];
//wire	gpio3_io_in[4];
//wire	gpio3_io_in[5];
//wire	gpio3_io_in[6];
//wire	gpio3_io_in[7];
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
wire	[11:0] \macro_inst|adc1_data ;
//wire	\macro_inst|adc1_data [0];
//wire	\macro_inst|adc1_data [10];
//wire	\macro_inst|adc1_data [11];
//wire	\macro_inst|adc1_data [1];
//wire	\macro_inst|adc1_data [2];
//wire	\macro_inst|adc1_data [3];
//wire	\macro_inst|adc1_data [4];
//wire	\macro_inst|adc1_data [5];
//wire	\macro_inst|adc1_data [6];
//wire	\macro_inst|adc1_data [7];
//wire	\macro_inst|adc1_data [8];
//wire	\macro_inst|adc1_data [9];
wire	\macro_inst|adc1_eoc ;
reg	\macro_inst|adc1_eoc_d ;
wire	\macro_inst|adc1_eoc_d_A_Y ;
wire	\macro_inst|adc1_eoc_inv ;
reg	[11:0] \macro_inst|adc1_latest ;
//reg	\macro_inst|adc1_latest [0];
wire	\macro_inst|adc1_latest[0]_reg__feeder__LutOut ;
//reg	\macro_inst|adc1_latest [10];
wire	\macro_inst|adc1_latest[10]_reg__feeder__LutOut ;
//reg	\macro_inst|adc1_latest [11];
wire	\macro_inst|adc1_latest[11]_reg__feeder__LutOut ;
//reg	\macro_inst|adc1_latest [1];
wire	\macro_inst|adc1_latest[1]_reg__feeder__LutOut ;
//reg	\macro_inst|adc1_latest [2];
wire	\macro_inst|adc1_latest[2]_reg__feeder__LutOut ;
//reg	\macro_inst|adc1_latest [3];
wire	\macro_inst|adc1_latest[3]_reg__feeder__LutOut ;
//reg	\macro_inst|adc1_latest [4];
wire	\macro_inst|adc1_latest[4]_reg__feeder__LutOut ;
//reg	\macro_inst|adc1_latest [5];
wire	\macro_inst|adc1_latest[5]_reg__feeder__LutOut ;
//reg	\macro_inst|adc1_latest [6];
wire	\macro_inst|adc1_latest[6]_reg__feeder__LutOut ;
//reg	\macro_inst|adc1_latest [7];
wire	\macro_inst|adc1_latest[7]_reg__feeder__LutOut ;
//reg	\macro_inst|adc1_latest [8];
wire	\macro_inst|adc1_latest[8]_reg__feeder__LutOut ;
//reg	\macro_inst|adc1_latest [9];
wire	\macro_inst|adc1_latest[9]_reg__feeder__LutOut ;
wire	\macro_inst|adc1_latest_A_1_Y_A_Y ;
wire	\macro_inst|adc1_latest_dataa_0_combout ;
wire	\macro_inst|adc1_latest_dataa_1_combout ;
reg	\macro_inst|adc1_valid ;
wire	\macro_inst|adc1_valid_reg__feeder__LutOut ;
wire	[11:0] \macro_inst|adc2_data ;
//wire	\macro_inst|adc2_data [0];
//wire	\macro_inst|adc2_data [10];
//wire	\macro_inst|adc2_data [11];
//wire	\macro_inst|adc2_data [1];
//wire	\macro_inst|adc2_data [2];
//wire	\macro_inst|adc2_data [3];
//wire	\macro_inst|adc2_data [4];
//wire	\macro_inst|adc2_data [5];
//wire	\macro_inst|adc2_data [6];
//wire	\macro_inst|adc2_data [7];
//wire	\macro_inst|adc2_data [8];
//wire	\macro_inst|adc2_data [9];
wire	\macro_inst|adc2_eoc ;
reg	\macro_inst|adc2_eoc_d ;
wire	\macro_inst|adc2_eoc_d_A_Y ;
wire	\macro_inst|adc2_eoc_inv ;
reg	[11:0] \macro_inst|adc2_latest ;
//reg	\macro_inst|adc2_latest [0];
//reg	\macro_inst|adc2_latest [10];
//reg	\macro_inst|adc2_latest [11];
//reg	\macro_inst|adc2_latest [1];
wire	\macro_inst|adc2_latest[1]_reg__feeder__LutOut ;
//reg	\macro_inst|adc2_latest [2];
//reg	\macro_inst|adc2_latest [3];
//reg	\macro_inst|adc2_latest [4];
wire	\macro_inst|adc2_latest[4]_reg__feeder__LutOut ;
//reg	\macro_inst|adc2_latest [5];
//reg	\macro_inst|adc2_latest [6];
//reg	\macro_inst|adc2_latest [7];
wire	\macro_inst|adc2_latest[7]_reg__feeder__LutOut ;
//reg	\macro_inst|adc2_latest [8];
//reg	\macro_inst|adc2_latest [9];
wire	\macro_inst|adc2_latest[9]_reg__feeder__LutOut ;
wire	\macro_inst|adc2_latest_A_0_Y_A_Y ;
wire	\macro_inst|adc2_latest_A_10_Y_A_Y ;
wire	\macro_inst|adc2_latest_A_11_Y_A_Y ;
wire	\macro_inst|adc2_latest_A_2_Y_A_Y ;
wire	\macro_inst|adc2_latest_A_3_Y_A_Y ;
wire	\macro_inst|adc2_latest_A_4_Y_A_Y ;
wire	\macro_inst|adc2_latest_A_5_Y_A_Y ;
wire	\macro_inst|adc2_latest_A_6_Y_A_Y ;
wire	\macro_inst|adc2_latest_A_7_Y_A_Y ;
wire	\macro_inst|adc2_latest_A_8_Y_A_Y ;
wire	\macro_inst|adc2_latest_A_9_Y_A_Y ;
reg	\macro_inst|adc2_valid ;
wire	\macro_inst|adc2_valid_reg__feeder__LutOut ;
reg	[3:0] \macro_inst|adc_clk_div ;
//reg	\macro_inst|adc_clk_div [0];
//reg	\macro_inst|adc_clk_div [1];
//reg	\macro_inst|adc_clk_div [2];
//reg	\macro_inst|adc_clk_div [3];
wire	\macro_inst|adc_clk_div_dataa_1_combout ;
wire	\macro_inst|adc_clk_div_datab_0_combout ;
wire	\macro_inst|adc_clk_div_datab_0_combout_A_Y ;
wire	[4:0] \macro_inst|adc_clk_div_datab_0_cout ;
//wire	\macro_inst|adc_clk_div_datab_0_cout [0];
//wire	\macro_inst|adc_clk_div_datab_0_cout [1];
//wire	\macro_inst|adc_clk_div_datab_0_cout [2];
//wire	\macro_inst|adc_clk_div_datab_0_cout [3];
//wire	\macro_inst|adc_clk_div_datab_0_cout [4];
wire	\macro_inst|adc_clk_div_datab_1_combout ;
wire	\macro_inst|adc_clk_div_datab_1_combout_A_Y ;
wire	\macro_inst|adc_clk_div_datab_2_combout ;
wire	\macro_inst|adc_clk_div_datab_2_combout_A_Y ;
wire	\macro_inst|adc_clk_div_datab_3_combout ;
wire	\macro_inst|adc_clk_div_datab_3_combout_A_Y ;
reg	\macro_inst|adc_sclk ;
wire	\macro_inst|adc_sclk_A_Y ;
wire	[3:0] \macro_inst|apb_paddr ;
//wire	\macro_inst|apb_paddr [0];
//wire	\macro_inst|apb_paddr [1];
//wire	\macro_inst|apb_paddr [2];
//wire	\macro_inst|apb_paddr [3];
reg	\macro_inst|apb_penable ;
wire	\macro_inst|apb_penable_B_Y ;
wire	[31:0] \macro_inst|apb_prdata ;
//wire	\macro_inst|apb_prdata [0];
//wire	\macro_inst|apb_prdata [10];
//wire	\macro_inst|apb_prdata [11];
//wire	\macro_inst|apb_prdata [12];
//wire	\macro_inst|apb_prdata [13];
//wire	\macro_inst|apb_prdata [14];
//wire	\macro_inst|apb_prdata [15];
//wire	\macro_inst|apb_prdata [16];
//wire	\macro_inst|apb_prdata [17];
//wire	\macro_inst|apb_prdata [18];
//wire	\macro_inst|apb_prdata [19];
//wire	\macro_inst|apb_prdata [1];
//wire	\macro_inst|apb_prdata [20];
//wire	\macro_inst|apb_prdata [21];
//wire	\macro_inst|apb_prdata [22];
//wire	\macro_inst|apb_prdata [23];
//wire	\macro_inst|apb_prdata [24];
//wire	\macro_inst|apb_prdata [25];
//wire	\macro_inst|apb_prdata [26];
//wire	\macro_inst|apb_prdata [27];
//wire	\macro_inst|apb_prdata [28];
//wire	\macro_inst|apb_prdata [29];
//wire	\macro_inst|apb_prdata [2];
//wire	\macro_inst|apb_prdata [30];
//wire	\macro_inst|apb_prdata [31];
//wire	\macro_inst|apb_prdata [3];
//wire	\macro_inst|apb_prdata [4];
//wire	\macro_inst|apb_prdata [5];
//wire	\macro_inst|apb_prdata [6];
//wire	\macro_inst|apb_prdata [7];
//wire	\macro_inst|apb_prdata [8];
//wire	\macro_inst|apb_prdata [9];
reg	\macro_inst|apb_psel ;
wire	\macro_inst|apb_psel_A_Y_B_Y ;
wire	[31:0] \macro_inst|apb_pwdata ;
//wire	\macro_inst|apb_pwdata [0];
//wire	\macro_inst|apb_pwdata [10];
//wire	\macro_inst|apb_pwdata [11];
//wire	\macro_inst|apb_pwdata [12];
//wire	\macro_inst|apb_pwdata [13];
//wire	\macro_inst|apb_pwdata [14];
//wire	\macro_inst|apb_pwdata [15];
//wire	\macro_inst|apb_pwdata [16];
//wire	\macro_inst|apb_pwdata [17];
//wire	\macro_inst|apb_pwdata [18];
//wire	\macro_inst|apb_pwdata [19];
//wire	\macro_inst|apb_pwdata [1];
//wire	\macro_inst|apb_pwdata [20];
//wire	\macro_inst|apb_pwdata [21];
//wire	\macro_inst|apb_pwdata [22];
//wire	\macro_inst|apb_pwdata [23];
//wire	\macro_inst|apb_pwdata [24];
//wire	\macro_inst|apb_pwdata [25];
//wire	\macro_inst|apb_pwdata [26];
//wire	\macro_inst|apb_pwdata [27];
//wire	\macro_inst|apb_pwdata [28];
//wire	\macro_inst|apb_pwdata [29];
//wire	\macro_inst|apb_pwdata [2];
//wire	\macro_inst|apb_pwdata [30];
//wire	\macro_inst|apb_pwdata [31];
//wire	\macro_inst|apb_pwdata [3];
//wire	\macro_inst|apb_pwdata [4];
//wire	\macro_inst|apb_pwdata [5];
//wire	\macro_inst|apb_pwdata [6];
//wire	\macro_inst|apb_pwdata [7];
//wire	\macro_inst|apb_pwdata [8];
//wire	\macro_inst|apb_pwdata [9];
reg	\macro_inst|apb_pwrite ;
wire	[2:0] \macro_inst|bridge|ahb_hburst ;
//wire	\macro_inst|bridge|ahb_hburst [0];
//wire	\macro_inst|bridge|ahb_hburst [1];
//wire	\macro_inst|bridge|ahb_hburst [2];
wire	[31:0] \macro_inst|bridge|ahb_hrdata ;
//wire	\macro_inst|bridge|ahb_hrdata [0];
//wire	\macro_inst|bridge|ahb_hrdata [10];
//wire	\macro_inst|bridge|ahb_hrdata [11];
//wire	\macro_inst|bridge|ahb_hrdata [12];
//wire	\macro_inst|bridge|ahb_hrdata [13];
//wire	\macro_inst|bridge|ahb_hrdata [14];
//wire	\macro_inst|bridge|ahb_hrdata [15];
//wire	\macro_inst|bridge|ahb_hrdata [16];
//wire	\macro_inst|bridge|ahb_hrdata [17];
//wire	\macro_inst|bridge|ahb_hrdata [18];
//wire	\macro_inst|bridge|ahb_hrdata [19];
//wire	\macro_inst|bridge|ahb_hrdata [1];
//wire	\macro_inst|bridge|ahb_hrdata [20];
//wire	\macro_inst|bridge|ahb_hrdata [21];
//wire	\macro_inst|bridge|ahb_hrdata [22];
//wire	\macro_inst|bridge|ahb_hrdata [23];
//wire	\macro_inst|bridge|ahb_hrdata [24];
//wire	\macro_inst|bridge|ahb_hrdata [25];
//wire	\macro_inst|bridge|ahb_hrdata [26];
//wire	\macro_inst|bridge|ahb_hrdata [27];
//wire	\macro_inst|bridge|ahb_hrdata [28];
//wire	\macro_inst|bridge|ahb_hrdata [29];
//wire	\macro_inst|bridge|ahb_hrdata [2];
//wire	\macro_inst|bridge|ahb_hrdata [30];
//wire	\macro_inst|bridge|ahb_hrdata [31];
//wire	\macro_inst|bridge|ahb_hrdata [3];
//wire	\macro_inst|bridge|ahb_hrdata [4];
//wire	\macro_inst|bridge|ahb_hrdata [5];
//wire	\macro_inst|bridge|ahb_hrdata [6];
//wire	\macro_inst|bridge|ahb_hrdata [7];
//wire	\macro_inst|bridge|ahb_hrdata [8];
//wire	\macro_inst|bridge|ahb_hrdata [9];
wire	\macro_inst|bridge|ahb_hready ;
wire	\macro_inst|bridge|ahb_hreadyout_A_Y ;
wire	\macro_inst|bridge|ahb_hreadyout_A_Y_inv ;
wire	[2:0] \macro_inst|bridge|ahb_hsize ;
//wire	\macro_inst|bridge|ahb_hsize [0];
//wire	\macro_inst|bridge|ahb_hsize [1];
//wire	\macro_inst|bridge|ahb_hsize [2];
wire	[1:0] \macro_inst|bridge|ahb_htrans ;
//wire	\macro_inst|bridge|ahb_htrans [0];
//wire	\macro_inst|bridge|ahb_htrans [1];
wire	\macro_inst|bridge|ahb_htrans_B_1_Y ;
wire	\macro_inst|bridge|ahb_htrans_B_1_Y__SyncLoad_X10003_Y10001_SIG ;
wire	\macro_inst|bridge|ahb_hwrite ;
wire	[2:0] \macro_inst|bridge|apbState ;
//wire	\macro_inst|bridge|apbState [0];
reg	\macro_inst|bridge|apbState[0]_reg_q ;
//wire	\macro_inst|bridge|apbState [1];
wire	\macro_inst|bridge|apbState[1]_reg__feeder__LutOut ;
//wire	\macro_inst|bridge|apbState [2];
wire	\macro_inst|bridge|apbState_A_1_Y ;
wire	\macro_inst|bridge|apb_pdone ;
wire	[3:0] \macro_inst|bridge|haddr ;
//wire	\macro_inst|bridge|haddr [0];
//wire	\macro_inst|bridge|haddr [1];
//wire	\macro_inst|bridge|haddr [2];
wire	\macro_inst|bridge|haddr[2]_reg__feeder__LutOut ;
//wire	\macro_inst|bridge|haddr [3];
wire	\macro_inst|bridge|haddr[3]_reg__feeder__LutOut ;
reg	\macro_inst|bridge|hdone_reg_q ;
reg	\macro_inst|bridge|hreadyout_reg_q ;
wire	\macro_inst|bridge|hreadyout_reg_q_A_Y ;
wire	\macro_inst|bridge|hreadyout_reg_q_S_Y ;
wire	\macro_inst|bridge|hreadyout_reg_q_S_Y_inv ;
reg	\macro_inst|bridge|hwrite ;
wire	\macro_inst|bridge|hwrite_reg__feeder__LutOut ;
wire	\macro_inst|bridge|paddr[2]_reg__feeder__LutOut ;
wire	\macro_inst|bridge|paddr[3]_reg__feeder__LutOut ;
reg	\macro_inst|bridge|pdone ;
wire	\macro_inst|bridge|pdone_B_1_Y ;
wire	\macro_inst|bridge|prdata[10]_reg__feeder__LutOut ;
wire	\macro_inst|bridge|prdata[1]_reg__feeder__LutOut ;
wire	\macro_inst|bridge|prdata[2]_reg__feeder__LutOut ;
wire	\macro_inst|bridge|prdata[3]_reg__feeder__LutOut ;
wire	\macro_inst|bridge|prdata[7]_reg__feeder__LutOut ;
wire	\macro_inst|bridge|prdata[9]_reg__feeder__LutOut ;
reg	\macro_inst|bridge|pvalid ;
wire	\macro_inst|bridge|pvalid_A_1_Y_A_Y ;
wire	\macro_inst|bridge|pvalid_A_1_Y_A_Y_inv ;
wire	\macro_inst|bridge|pvalid_A_Y ;
wire	\macro_inst|bridge|pvalid_A_Y__SyncLoad_X10005_Y10001_SIG ;
wire	\macro_inst|bridge|pwrite_reg__feeder__LutOut ;
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
wire	sys_resetn__AsyncReset_X10001_Y10001_INV;
wire	sys_resetn__AsyncReset_X10002_Y10001_INV;
wire	sys_resetn__AsyncReset_X10003_Y10001_INV;
wire	sys_resetn__AsyncReset_X10004_Y10001_INV;
wire	sys_resetn__AsyncReset_X10005_Y10001_INV;
wire	sys_resetn__AsyncReset_X10006_Y10001_INV;
wire	sys_resetn__AsyncReset_X10007_Y10001_INV;
wire	sys_resetn_int;

wire vcc;
wire gnd;
assign vcc = 1'b1;
assign gnd = 1'b0;
wire unknown;
assign unknown = 1'bx;

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

alta_asyncctrl asyncreset_ctrl_X10001_Y10001_N0(
	.Din(sys_resetn),
	.Dout(sys_resetn__AsyncReset_X10001_Y10001_INV));
defparam asyncreset_ctrl_X10001_Y10001_N0.coord_x = 20;
defparam asyncreset_ctrl_X10001_Y10001_N0.coord_y = 12;
defparam asyncreset_ctrl_X10001_Y10001_N0.coord_z = 0;
defparam asyncreset_ctrl_X10001_Y10001_N0.AsyncCtrlMux = 2'b11;

alta_asyncctrl asyncreset_ctrl_X10002_Y10001_N0(
	.Din(sys_resetn),
	.Dout(sys_resetn__AsyncReset_X10002_Y10001_INV));
defparam asyncreset_ctrl_X10002_Y10001_N0.coord_x = 19;
defparam asyncreset_ctrl_X10002_Y10001_N0.coord_y = 12;
defparam asyncreset_ctrl_X10002_Y10001_N0.coord_z = 0;
defparam asyncreset_ctrl_X10002_Y10001_N0.AsyncCtrlMux = 2'b11;

alta_asyncctrl asyncreset_ctrl_X10003_Y10001_N1(
	.Din(sys_resetn),
	.Dout(sys_resetn__AsyncReset_X10003_Y10001_INV));
defparam asyncreset_ctrl_X10003_Y10001_N1.coord_x = 14;
defparam asyncreset_ctrl_X10003_Y10001_N1.coord_y = 12;
defparam asyncreset_ctrl_X10003_Y10001_N1.coord_z = 1;
defparam asyncreset_ctrl_X10003_Y10001_N1.AsyncCtrlMux = 2'b11;

alta_asyncctrl asyncreset_ctrl_X10004_Y10001_N0(
	.Din(sys_resetn),
	.Dout(sys_resetn__AsyncReset_X10004_Y10001_INV));
defparam asyncreset_ctrl_X10004_Y10001_N0.coord_x = 15;
defparam asyncreset_ctrl_X10004_Y10001_N0.coord_y = 12;
defparam asyncreset_ctrl_X10004_Y10001_N0.coord_z = 0;
defparam asyncreset_ctrl_X10004_Y10001_N0.AsyncCtrlMux = 2'b11;

alta_asyncctrl asyncreset_ctrl_X10005_Y10001_N0(
	.Din(sys_resetn),
	.Dout(sys_resetn__AsyncReset_X10005_Y10001_INV));
defparam asyncreset_ctrl_X10005_Y10001_N0.coord_x = 18;
defparam asyncreset_ctrl_X10005_Y10001_N0.coord_y = 12;
defparam asyncreset_ctrl_X10005_Y10001_N0.coord_z = 0;
defparam asyncreset_ctrl_X10005_Y10001_N0.AsyncCtrlMux = 2'b11;

alta_asyncctrl asyncreset_ctrl_X10006_Y10001_N0(
	.Din(sys_resetn),
	.Dout(sys_resetn__AsyncReset_X10006_Y10001_INV));
defparam asyncreset_ctrl_X10006_Y10001_N0.coord_x = 18;
defparam asyncreset_ctrl_X10006_Y10001_N0.coord_y = 10;
defparam asyncreset_ctrl_X10006_Y10001_N0.coord_z = 0;
defparam asyncreset_ctrl_X10006_Y10001_N0.AsyncCtrlMux = 2'b11;

alta_asyncctrl asyncreset_ctrl_X10007_Y10001_N0(
	.Din(sys_resetn),
	.Dout(sys_resetn__AsyncReset_X10007_Y10001_INV));
defparam asyncreset_ctrl_X10007_Y10001_N0.coord_x = 19;
defparam asyncreset_ctrl_X10007_Y10001_N0.coord_y = 10;
defparam asyncreset_ctrl_X10007_Y10001_N0.coord_z = 0;
defparam asyncreset_ctrl_X10007_Y10001_N0.AsyncCtrlMux = 2'b11;

alta_clkenctrl clken_ctrl_X10001_Y10001_N0(
	.ClkIn(bus_clk),
	.ClkEn(),
	.ClkOut(bus_clk_X10001_Y10001_SIG_VCC));
defparam clken_ctrl_X10001_Y10001_N0.coord_x = 20;
defparam clken_ctrl_X10001_Y10001_N0.coord_y = 12;
defparam clken_ctrl_X10001_Y10001_N0.coord_z = 0;
defparam clken_ctrl_X10001_Y10001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X10001_Y10001_N0.ClkEnMux = 2'b01;

alta_clkenctrl clken_ctrl_X10001_Y10001_N1(
	.ClkIn(bus_clk),
	.ClkEn(\macro_inst|adc2_eoc_d_A_Y ),
	.ClkOut(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10001_Y10001_SIG_SIG ));
defparam clken_ctrl_X10001_Y10001_N1.coord_x = 20;
defparam clken_ctrl_X10001_Y10001_N1.coord_y = 12;
defparam clken_ctrl_X10001_Y10001_N1.coord_z = 1;
defparam clken_ctrl_X10001_Y10001_N1.ClkMux = 2'b10;
defparam clken_ctrl_X10001_Y10001_N1.ClkEnMux = 2'b10;

alta_clkenctrl clken_ctrl_X10002_Y10001_N0(
	.ClkIn(bus_clk),
	.ClkEn(\macro_inst|apb_penable_B_Y ),
	.ClkOut(\bus_clk__macro_inst|apb_penable_B_Y_X10002_Y10001_SIG_SIG ));
defparam clken_ctrl_X10002_Y10001_N0.coord_x = 19;
defparam clken_ctrl_X10002_Y10001_N0.coord_y = 12;
defparam clken_ctrl_X10002_Y10001_N0.coord_z = 0;
defparam clken_ctrl_X10002_Y10001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X10002_Y10001_N0.ClkEnMux = 2'b10;

alta_clkenctrl clken_ctrl_X10002_Y10001_N1(
	.ClkIn(bus_clk),
	.ClkEn(\macro_inst|adc1_eoc_d_A_Y ),
	.ClkOut(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10002_Y10001_SIG_SIG ));
defparam clken_ctrl_X10002_Y10001_N1.coord_x = 19;
defparam clken_ctrl_X10002_Y10001_N1.coord_y = 12;
defparam clken_ctrl_X10002_Y10001_N1.coord_z = 1;
defparam clken_ctrl_X10002_Y10001_N1.ClkMux = 2'b10;
defparam clken_ctrl_X10002_Y10001_N1.ClkEnMux = 2'b10;

alta_clkenctrl clken_ctrl_X10003_Y10001_N0(
	.ClkIn(bus_clk),
	.ClkEn(\macro_inst|bridge|apb_pdone ),
	.ClkOut(\bus_clk__macro_inst|bridge|apb_pdone_X10003_Y10001_SIG_SIG ));
defparam clken_ctrl_X10003_Y10001_N0.coord_x = 14;
defparam clken_ctrl_X10003_Y10001_N0.coord_y = 12;
defparam clken_ctrl_X10003_Y10001_N0.coord_z = 0;
defparam clken_ctrl_X10003_Y10001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X10003_Y10001_N0.ClkEnMux = 2'b10;

alta_clkenctrl clken_ctrl_X10003_Y10001_N1(
	.ClkIn(bus_clk),
	.ClkEn(),
	.ClkOut(bus_clk_X10003_Y10001_SIG_VCC));
defparam clken_ctrl_X10003_Y10001_N1.coord_x = 14;
defparam clken_ctrl_X10003_Y10001_N1.coord_y = 12;
defparam clken_ctrl_X10003_Y10001_N1.coord_z = 1;
defparam clken_ctrl_X10003_Y10001_N1.ClkMux = 2'b10;
defparam clken_ctrl_X10003_Y10001_N1.ClkEnMux = 2'b01;

alta_clkenctrl clken_ctrl_X10004_Y10001_N0(
	.ClkIn(bus_clk),
	.ClkEn(),
	.ClkOut(bus_clk_X10004_Y10001_SIG_VCC));
defparam clken_ctrl_X10004_Y10001_N0.coord_x = 15;
defparam clken_ctrl_X10004_Y10001_N0.coord_y = 12;
defparam clken_ctrl_X10004_Y10001_N0.coord_z = 0;
defparam clken_ctrl_X10004_Y10001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X10004_Y10001_N0.ClkEnMux = 2'b01;

alta_clkenctrl clken_ctrl_X10004_Y10001_N1(
	.ClkIn(bus_clk),
	.ClkEn(\macro_inst|bridge|apb_pdone ),
	.ClkOut(\bus_clk__macro_inst|bridge|apb_pdone_X10004_Y10001_SIG_SIG ));
defparam clken_ctrl_X10004_Y10001_N1.coord_x = 15;
defparam clken_ctrl_X10004_Y10001_N1.coord_y = 12;
defparam clken_ctrl_X10004_Y10001_N1.coord_z = 1;
defparam clken_ctrl_X10004_Y10001_N1.ClkMux = 2'b10;
defparam clken_ctrl_X10004_Y10001_N1.ClkEnMux = 2'b10;

alta_clkenctrl clken_ctrl_X10005_Y10001_N0(
	.ClkIn(bus_clk),
	.ClkEn(\macro_inst|adc2_eoc_d_A_Y ),
	.ClkOut(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10005_Y10001_SIG_SIG ));
defparam clken_ctrl_X10005_Y10001_N0.coord_x = 18;
defparam clken_ctrl_X10005_Y10001_N0.coord_y = 12;
defparam clken_ctrl_X10005_Y10001_N0.coord_z = 0;
defparam clken_ctrl_X10005_Y10001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X10005_Y10001_N0.ClkEnMux = 2'b10;

alta_clkenctrl clken_ctrl_X10005_Y10001_N1(
	.ClkIn(bus_clk),
	.ClkEn(),
	.ClkOut(bus_clk_X10005_Y10001_SIG_VCC));
defparam clken_ctrl_X10005_Y10001_N1.coord_x = 18;
defparam clken_ctrl_X10005_Y10001_N1.coord_y = 12;
defparam clken_ctrl_X10005_Y10001_N1.coord_z = 1;
defparam clken_ctrl_X10005_Y10001_N1.ClkMux = 2'b10;
defparam clken_ctrl_X10005_Y10001_N1.ClkEnMux = 2'b01;

alta_clkenctrl clken_ctrl_X10006_Y10001_N0(
	.ClkIn(bus_clk),
	.ClkEn(\macro_inst|apb_penable_B_Y ),
	.ClkOut(\bus_clk__macro_inst|apb_penable_B_Y_X10006_Y10001_SIG_SIG ));
defparam clken_ctrl_X10006_Y10001_N0.coord_x = 18;
defparam clken_ctrl_X10006_Y10001_N0.coord_y = 10;
defparam clken_ctrl_X10006_Y10001_N0.coord_z = 0;
defparam clken_ctrl_X10006_Y10001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X10006_Y10001_N0.ClkEnMux = 2'b10;

alta_clkenctrl clken_ctrl_X10006_Y10001_N1(
	.ClkIn(bus_clk),
	.ClkEn(\macro_inst|adc2_eoc_d_A_Y ),
	.ClkOut(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10006_Y10001_SIG_SIG ));
defparam clken_ctrl_X10006_Y10001_N1.coord_x = 18;
defparam clken_ctrl_X10006_Y10001_N1.coord_y = 10;
defparam clken_ctrl_X10006_Y10001_N1.coord_z = 1;
defparam clken_ctrl_X10006_Y10001_N1.ClkMux = 2'b10;
defparam clken_ctrl_X10006_Y10001_N1.ClkEnMux = 2'b10;

alta_clkenctrl clken_ctrl_X10007_Y10001_N0(
	.ClkIn(bus_clk),
	.ClkEn(\macro_inst|adc1_eoc_d_A_Y ),
	.ClkOut(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10007_Y10001_SIG_SIG ));
defparam clken_ctrl_X10007_Y10001_N0.coord_x = 19;
defparam clken_ctrl_X10007_Y10001_N0.coord_y = 10;
defparam clken_ctrl_X10007_Y10001_N0.coord_z = 0;
defparam clken_ctrl_X10007_Y10001_N0.ClkMux = 2'b10;
defparam clken_ctrl_X10007_Y10001_N0.ClkEnMux = 2'b10;

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
	.resetn(sys_resetn_int),
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

alta_rio gpio3_io_in_o_0(
	.padio(GPTIMER4_CH0),
	.datain(gpio3_io_out_data[0]),
	.oe(gpio3_io_out_en[0]),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(gpio3_io_in[0]),
	.regout());
defparam gpio3_io_in_o_0.coord_x = 19;
defparam gpio3_io_in_o_0.coord_y = 0;
defparam gpio3_io_in_o_0.coord_z = 1;
defparam gpio3_io_in_o_0.IN_ASYNC_MODE = 1'b0;
defparam gpio3_io_in_o_0.IN_SYNC_MODE = 1'b0;
defparam gpio3_io_in_o_0.IN_POWERUP = 1'b0;
defparam gpio3_io_in_o_0.OUT_REG_MODE = 1'b0;
defparam gpio3_io_in_o_0.OUT_ASYNC_MODE = 1'b0;
defparam gpio3_io_in_o_0.OUT_SYNC_MODE = 1'b0;
defparam gpio3_io_in_o_0.OUT_POWERUP = 1'b0;
defparam gpio3_io_in_o_0.OE_REG_MODE = 1'b0;
defparam gpio3_io_in_o_0.OE_ASYNC_MODE = 1'b0;
defparam gpio3_io_in_o_0.OE_SYNC_MODE = 1'b0;
defparam gpio3_io_in_o_0.OE_POWERUP = 1'b0;
defparam gpio3_io_in_o_0.CFG_TRI_INPUT = 1'b0;
defparam gpio3_io_in_o_0.CFG_INPUT_EN = 1'b1;
defparam gpio3_io_in_o_0.CFG_PULL_UP = 1'b0;
defparam gpio3_io_in_o_0.CFG_SLR = 1'b0;
defparam gpio3_io_in_o_0.CFG_OPEN_DRAIN = 1'b0;
defparam gpio3_io_in_o_0.CFG_PDRCTRL = 4'b0100;
defparam gpio3_io_in_o_0.CFG_KEEP = 2'b00;
defparam gpio3_io_in_o_0.CFG_LVDS_OUT_EN = 1'b0;
defparam gpio3_io_in_o_0.CFG_LVDS_SEL_CUA = 2'b00;
defparam gpio3_io_in_o_0.CFG_LVDS_IREF = 10'b0110000000;
defparam gpio3_io_in_o_0.CFG_LVDS_IN_EN = 1'b0;
defparam gpio3_io_in_o_0.DPCLK_DELAY = 4'b0000;
defparam gpio3_io_in_o_0.OUT_DELAY = 1'b0;
defparam gpio3_io_in_o_0.IN_DATA_DELAY = 3'b000;
defparam gpio3_io_in_o_0.IN_REG_DELAY = 3'b000;

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

alta_slice \macro_inst|adc1_eoc_d_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc1_eoc ),
	.Cin(),
	.Qin(\macro_inst|adc1_eoc_d ),
	.Clk(bus_clk_X10001_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_eoc_inv ),
	.Cout(),
	.Q(\macro_inst|adc1_eoc_d ));
defparam \macro_inst|adc1_eoc_d_reg .coord_x = 20;
defparam \macro_inst|adc1_eoc_d_reg .coord_y = 12;
defparam \macro_inst|adc1_eoc_d_reg .coord_z = 10;
defparam \macro_inst|adc1_eoc_d_reg .mask = 16'h00FF;
defparam \macro_inst|adc1_eoc_d_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_eoc_d_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_eoc_d_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_eoc_d_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_eoc_d_reg .CarryEnb = 1'b1;

alta_adc \macro_inst|adc1_inst (
	.enb(!sys_resetn_int),
	.sclk(\macro_inst|adc_sclk ),
	.insel({gnd, vcc, gnd, vcc, gnd}),
	.stop(sys_ctrl_stop),
	.db({\macro_inst|adc1_data [11], \macro_inst|adc1_data [10], \macro_inst|adc1_data [9], \macro_inst|adc1_data [8], \macro_inst|adc1_data [7], \macro_inst|adc1_data [6], \macro_inst|adc1_data [5], \macro_inst|adc1_data [4], \macro_inst|adc1_data [3], \macro_inst|adc1_data [2], \macro_inst|adc1_data [1], \macro_inst|adc1_data [0]}),
	.eoc(\macro_inst|adc1_eoc ));
defparam \macro_inst|adc1_inst .coord_x = 22;
defparam \macro_inst|adc1_inst .coord_y = 7;
defparam \macro_inst|adc1_inst .coord_z = 0;

alta_slice \macro_inst|adc1_latest[0]_reg (
	.A(),
	.B(),
	.C(\macro_inst|adc1_data [0]),
	.D(),
	.Cin(),
	.Qin(\macro_inst|adc1_latest [0]),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest[0]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_latest [0]));
defparam \macro_inst|adc1_latest[0]_reg .coord_x = 19;
defparam \macro_inst|adc1_latest[0]_reg .coord_y = 12;
defparam \macro_inst|adc1_latest[0]_reg .coord_z = 2;
defparam \macro_inst|adc1_latest[0]_reg .mask = 16'hF0F0;
defparam \macro_inst|adc1_latest[0]_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_latest[0]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest[0]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest[0]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest[0]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest[10]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc1_data [10]),
	.Cin(),
	.Qin(\macro_inst|adc1_latest [10]),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10007_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10007_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest[10]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_latest [10]));
defparam \macro_inst|adc1_latest[10]_reg .coord_x = 19;
defparam \macro_inst|adc1_latest[10]_reg .coord_y = 10;
defparam \macro_inst|adc1_latest[10]_reg .coord_z = 2;
defparam \macro_inst|adc1_latest[10]_reg .mask = 16'hFF00;
defparam \macro_inst|adc1_latest[10]_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_latest[10]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest[10]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest[10]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest[10]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest[11]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc1_data [11]),
	.Cin(),
	.Qin(\macro_inst|adc1_latest [11]),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10007_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10007_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest[11]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_latest [11]));
defparam \macro_inst|adc1_latest[11]_reg .coord_x = 19;
defparam \macro_inst|adc1_latest[11]_reg .coord_y = 10;
defparam \macro_inst|adc1_latest[11]_reg .coord_z = 6;
defparam \macro_inst|adc1_latest[11]_reg .mask = 16'hFF00;
defparam \macro_inst|adc1_latest[11]_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_latest[11]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest[11]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest[11]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest[11]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest[1]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc1_data [1]),
	.Cin(),
	.Qin(\macro_inst|adc1_latest [1]),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest[1]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_latest [1]));
defparam \macro_inst|adc1_latest[1]_reg .coord_x = 19;
defparam \macro_inst|adc1_latest[1]_reg .coord_y = 12;
defparam \macro_inst|adc1_latest[1]_reg .coord_z = 8;
defparam \macro_inst|adc1_latest[1]_reg .mask = 16'hFF00;
defparam \macro_inst|adc1_latest[1]_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_latest[1]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest[1]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest[1]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest[1]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest[2]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc1_data [2]),
	.Cin(),
	.Qin(\macro_inst|adc1_latest [2]),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10007_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10007_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest[2]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_latest [2]));
defparam \macro_inst|adc1_latest[2]_reg .coord_x = 19;
defparam \macro_inst|adc1_latest[2]_reg .coord_y = 10;
defparam \macro_inst|adc1_latest[2]_reg .coord_z = 4;
defparam \macro_inst|adc1_latest[2]_reg .mask = 16'hFF00;
defparam \macro_inst|adc1_latest[2]_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_latest[2]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest[2]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest[2]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest[2]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest[3]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc1_data [3]),
	.Cin(),
	.Qin(\macro_inst|adc1_latest [3]),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest[3]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_latest [3]));
defparam \macro_inst|adc1_latest[3]_reg .coord_x = 19;
defparam \macro_inst|adc1_latest[3]_reg .coord_y = 12;
defparam \macro_inst|adc1_latest[3]_reg .coord_z = 14;
defparam \macro_inst|adc1_latest[3]_reg .mask = 16'hFF00;
defparam \macro_inst|adc1_latest[3]_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_latest[3]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest[3]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest[3]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest[3]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest[4]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc1_data [4]),
	.Cin(),
	.Qin(\macro_inst|adc1_latest [4]),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest[4]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_latest [4]));
defparam \macro_inst|adc1_latest[4]_reg .coord_x = 19;
defparam \macro_inst|adc1_latest[4]_reg .coord_y = 12;
defparam \macro_inst|adc1_latest[4]_reg .coord_z = 5;
defparam \macro_inst|adc1_latest[4]_reg .mask = 16'hFF00;
defparam \macro_inst|adc1_latest[4]_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_latest[4]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest[4]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest[4]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest[4]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest[5]_reg (
	.A(),
	.B(),
	.C(\macro_inst|adc1_data [5]),
	.D(),
	.Cin(),
	.Qin(\macro_inst|adc1_latest [5]),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10007_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10007_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest[5]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_latest [5]));
defparam \macro_inst|adc1_latest[5]_reg .coord_x = 19;
defparam \macro_inst|adc1_latest[5]_reg .coord_y = 10;
defparam \macro_inst|adc1_latest[5]_reg .coord_z = 5;
defparam \macro_inst|adc1_latest[5]_reg .mask = 16'hF0F0;
defparam \macro_inst|adc1_latest[5]_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_latest[5]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest[5]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest[5]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest[5]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest[6]_reg (
	.A(\macro_inst|adc1_data [6]),
	.B(),
	.C(),
	.D(),
	.Cin(),
	.Qin(\macro_inst|adc1_latest [6]),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10007_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10007_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest[6]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_latest [6]));
defparam \macro_inst|adc1_latest[6]_reg .coord_x = 19;
defparam \macro_inst|adc1_latest[6]_reg .coord_y = 10;
defparam \macro_inst|adc1_latest[6]_reg .coord_z = 7;
defparam \macro_inst|adc1_latest[6]_reg .mask = 16'hAAAA;
defparam \macro_inst|adc1_latest[6]_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_latest[6]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest[6]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest[6]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest[6]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest[7]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc1_data [7]),
	.Cin(),
	.Qin(\macro_inst|adc1_latest [7]),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10007_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10007_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest[7]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_latest [7]));
defparam \macro_inst|adc1_latest[7]_reg .coord_x = 19;
defparam \macro_inst|adc1_latest[7]_reg .coord_y = 10;
defparam \macro_inst|adc1_latest[7]_reg .coord_z = 0;
defparam \macro_inst|adc1_latest[7]_reg .mask = 16'hFF00;
defparam \macro_inst|adc1_latest[7]_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_latest[7]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest[7]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest[7]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest[7]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest[8]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc1_data [8]),
	.Cin(),
	.Qin(\macro_inst|adc1_latest [8]),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10007_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10007_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest[8]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_latest [8]));
defparam \macro_inst|adc1_latest[8]_reg .coord_x = 19;
defparam \macro_inst|adc1_latest[8]_reg .coord_y = 10;
defparam \macro_inst|adc1_latest[8]_reg .coord_z = 3;
defparam \macro_inst|adc1_latest[8]_reg .mask = 16'hFF00;
defparam \macro_inst|adc1_latest[8]_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_latest[8]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest[8]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest[8]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest[8]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest[9]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc1_data [9]),
	.Cin(),
	.Qin(\macro_inst|adc1_latest [9]),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10007_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10007_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest[9]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_latest [9]));
defparam \macro_inst|adc1_latest[9]_reg .coord_x = 19;
defparam \macro_inst|adc1_latest[9]_reg .coord_y = 10;
defparam \macro_inst|adc1_latest[9]_reg .coord_z = 1;
defparam \macro_inst|adc1_latest[9]_reg .mask = 16'hFF00;
defparam \macro_inst|adc1_latest[9]_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_latest[9]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest[9]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest[9]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest[9]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest_dataa_0 (
	.A(\macro_inst|adc1_latest [0]),
	.B(\macro_inst|adc2_latest [0]),
	.C(\macro_inst|apb_paddr [2]),
	.D(\macro_inst|apb_paddr [3]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest_dataa_0_combout ),
	.Cout(),
	.Q());
defparam \macro_inst|adc1_latest_dataa_0 .coord_x = 19;
defparam \macro_inst|adc1_latest_dataa_0 .coord_y = 12;
defparam \macro_inst|adc1_latest_dataa_0 .coord_z = 3;
defparam \macro_inst|adc1_latest_dataa_0 .mask = 16'hF35F;
defparam \macro_inst|adc1_latest_dataa_0 .modeMux = 1'b0;
defparam \macro_inst|adc1_latest_dataa_0 .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest_dataa_0 .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest_dataa_0 .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest_dataa_0 .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_latest_dataa_1 (
	.A(\macro_inst|adc1_latest [1]),
	.B(\macro_inst|adc2_latest [1]),
	.C(\macro_inst|apb_paddr [2]),
	.D(\macro_inst|apb_paddr [3]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest_dataa_1_combout ),
	.Cout(),
	.Q());
defparam \macro_inst|adc1_latest_dataa_1 .coord_x = 19;
defparam \macro_inst|adc1_latest_dataa_1 .coord_y = 12;
defparam \macro_inst|adc1_latest_dataa_1 .coord_z = 7;
defparam \macro_inst|adc1_latest_dataa_1 .mask = 16'hF35F;
defparam \macro_inst|adc1_latest_dataa_1 .modeMux = 1'b0;
defparam \macro_inst|adc1_latest_dataa_1 .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_latest_dataa_1 .ShiftMux = 1'b0;
defparam \macro_inst|adc1_latest_dataa_1 .BypassEn = 1'b0;
defparam \macro_inst|adc1_latest_dataa_1 .CarryEnb = 1'b1;

alta_slice \macro_inst|adc1_valid_reg (
	.A(),
	.B(),
	.C(),
	.D(vcc),
	.Cin(),
	.Qin(\macro_inst|adc1_valid ),
	.Clk(\bus_clk__macro_inst|adc1_eoc_d_A_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_valid_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc1_valid ));
defparam \macro_inst|adc1_valid_reg .coord_x = 19;
defparam \macro_inst|adc1_valid_reg .coord_y = 12;
defparam \macro_inst|adc1_valid_reg .coord_z = 1;
defparam \macro_inst|adc1_valid_reg .mask = 16'hFF00;
defparam \macro_inst|adc1_valid_reg .modeMux = 1'b0;
defparam \macro_inst|adc1_valid_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc1_valid_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc1_valid_reg .BypassEn = 1'b0;
defparam \macro_inst|adc1_valid_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc2_eoc_d_reg (
	.A(),
	.B(),
	.C(\macro_inst|adc2_eoc ),
	.D(),
	.Cin(),
	.Qin(\macro_inst|adc2_eoc_d ),
	.Clk(bus_clk_X10001_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_eoc_inv ),
	.Cout(),
	.Q(\macro_inst|adc2_eoc_d ));
defparam \macro_inst|adc2_eoc_d_reg .coord_x = 20;
defparam \macro_inst|adc2_eoc_d_reg .coord_y = 12;
defparam \macro_inst|adc2_eoc_d_reg .coord_z = 12;
defparam \macro_inst|adc2_eoc_d_reg .mask = 16'h0F0F;
defparam \macro_inst|adc2_eoc_d_reg .modeMux = 1'b0;
defparam \macro_inst|adc2_eoc_d_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_eoc_d_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_eoc_d_reg .BypassEn = 1'b0;
defparam \macro_inst|adc2_eoc_d_reg .CarryEnb = 1'b1;

alta_adc \macro_inst|adc2_inst (
	.enb(!sys_resetn_int),
	.sclk(\macro_inst|adc_sclk ),
	.insel({gnd, vcc, gnd, gnd, vcc}),
	.stop(sys_ctrl_stop),
	.db({\macro_inst|adc2_data [11], \macro_inst|adc2_data [10], \macro_inst|adc2_data [9], \macro_inst|adc2_data [8], \macro_inst|adc2_data [7], \macro_inst|adc2_data [6], \macro_inst|adc2_data [5], \macro_inst|adc2_data [4], \macro_inst|adc2_data [3], \macro_inst|adc2_data [2], \macro_inst|adc2_data [1], \macro_inst|adc2_data [0]}),
	.eoc(\macro_inst|adc2_eoc ));
defparam \macro_inst|adc2_inst .coord_x = 22;
defparam \macro_inst|adc2_inst .coord_y = 8;
defparam \macro_inst|adc2_inst .coord_z = 0;

alta_slice \macro_inst|adc2_latest[0]_reg (
	.A(\macro_inst|adc_clk_div [0]),
	.B(vcc),
	.C(\macro_inst|adc2_data [0]),
	.D(vcc),
	.Cin(),
	.Qin(\macro_inst|adc2_latest [0]),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10001_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(SyncReset_X10001_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10001_Y10001_VCC),
	.LutOut(\macro_inst|adc_clk_div_datab_0_combout ),
	.Cout(\macro_inst|adc_clk_div_datab_0_cout [1]),
	.Q(\macro_inst|adc2_latest [0]));
defparam \macro_inst|adc2_latest[0]_reg .coord_x = 20;
defparam \macro_inst|adc2_latest[0]_reg .coord_y = 12;
defparam \macro_inst|adc2_latest[0]_reg .coord_z = 1;
defparam \macro_inst|adc2_latest[0]_reg .mask = 16'h6688;
defparam \macro_inst|adc2_latest[0]_reg .modeMux = 1'b1;
defparam \macro_inst|adc2_latest[0]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_latest[0]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_latest[0]_reg .BypassEn = 1'b1;
defparam \macro_inst|adc2_latest[0]_reg .CarryEnb = 1'b0;

alta_slice \macro_inst|adc2_latest[10]_reg (
	.A(),
	.B(),
	.C(\macro_inst|adc2_data [10]),
	.D(),
	.Cin(),
	.Qin(\macro_inst|adc2_latest [10]),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10001_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(SyncReset_X10001_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10001_Y10001_VCC),
	.LutOut(),
	.Cout(),
	.Q(\macro_inst|adc2_latest [10]));
defparam \macro_inst|adc2_latest[10]_reg .coord_x = 20;
defparam \macro_inst|adc2_latest[10]_reg .coord_y = 12;
defparam \macro_inst|adc2_latest[10]_reg .coord_z = 15;
defparam \macro_inst|adc2_latest[10]_reg .mask = 16'hFFFF;
defparam \macro_inst|adc2_latest[10]_reg .modeMux = 1'b1;
defparam \macro_inst|adc2_latest[10]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_latest[10]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_latest[10]_reg .BypassEn = 1'b1;
defparam \macro_inst|adc2_latest[10]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc2_latest[11]_reg (
	.A(),
	.B(),
	.C(\macro_inst|adc2_data [11]),
	.D(),
	.Cin(),
	.Qin(\macro_inst|adc2_latest [11]),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10001_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(SyncReset_X10001_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10001_Y10001_VCC),
	.LutOut(),
	.Cout(),
	.Q(\macro_inst|adc2_latest [11]));
defparam \macro_inst|adc2_latest[11]_reg .coord_x = 20;
defparam \macro_inst|adc2_latest[11]_reg .coord_y = 12;
defparam \macro_inst|adc2_latest[11]_reg .coord_z = 14;
defparam \macro_inst|adc2_latest[11]_reg .mask = 16'hFFFF;
defparam \macro_inst|adc2_latest[11]_reg .modeMux = 1'b1;
defparam \macro_inst|adc2_latest[11]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_latest[11]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_latest[11]_reg .BypassEn = 1'b1;
defparam \macro_inst|adc2_latest[11]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc2_latest[1]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc2_data [1]),
	.Cin(),
	.Qin(\macro_inst|adc2_latest [1]),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10005_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10005_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest[1]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc2_latest [1]));
defparam \macro_inst|adc2_latest[1]_reg .coord_x = 18;
defparam \macro_inst|adc2_latest[1]_reg .coord_y = 12;
defparam \macro_inst|adc2_latest[1]_reg .coord_z = 0;
defparam \macro_inst|adc2_latest[1]_reg .mask = 16'hFF00;
defparam \macro_inst|adc2_latest[1]_reg .modeMux = 1'b0;
defparam \macro_inst|adc2_latest[1]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_latest[1]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_latest[1]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc2_latest[1]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc2_latest[2]_reg (
	.A(\macro_inst|adc1_eoc_d ),
	.B(vcc),
	.C(\macro_inst|adc2_data [2]),
	.D(\macro_inst|adc1_eoc ),
	.Cin(),
	.Qin(\macro_inst|adc2_latest [2]),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10001_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(SyncReset_X10001_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10001_Y10001_VCC),
	.LutOut(\macro_inst|adc1_eoc_d_A_Y ),
	.Cout(),
	.Q(\macro_inst|adc2_latest [2]));
defparam \macro_inst|adc2_latest[2]_reg .coord_x = 20;
defparam \macro_inst|adc2_latest[2]_reg .coord_y = 12;
defparam \macro_inst|adc2_latest[2]_reg .coord_z = 13;
defparam \macro_inst|adc2_latest[2]_reg .mask = 16'h0055;
defparam \macro_inst|adc2_latest[2]_reg .modeMux = 1'b0;
defparam \macro_inst|adc2_latest[2]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_latest[2]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_latest[2]_reg .BypassEn = 1'b1;
defparam \macro_inst|adc2_latest[2]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc2_latest[3]_reg (
	.A(\macro_inst|adc2_eoc_d ),
	.B(\macro_inst|adc2_eoc ),
	.C(\macro_inst|adc2_data [3]),
	.D(vcc),
	.Cin(),
	.Qin(\macro_inst|adc2_latest [3]),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10001_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(SyncReset_X10001_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10001_Y10001_VCC),
	.LutOut(\macro_inst|adc2_eoc_d_A_Y ),
	.Cout(),
	.Q(\macro_inst|adc2_latest [3]));
defparam \macro_inst|adc2_latest[3]_reg .coord_x = 20;
defparam \macro_inst|adc2_latest[3]_reg .coord_y = 12;
defparam \macro_inst|adc2_latest[3]_reg .coord_z = 11;
defparam \macro_inst|adc2_latest[3]_reg .mask = 16'h1111;
defparam \macro_inst|adc2_latest[3]_reg .modeMux = 1'b0;
defparam \macro_inst|adc2_latest[3]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_latest[3]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_latest[3]_reg .BypassEn = 1'b1;
defparam \macro_inst|adc2_latest[3]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc2_latest[4]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc2_data [4]),
	.Cin(),
	.Qin(\macro_inst|adc2_latest [4]),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10006_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10006_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest[4]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc2_latest [4]));
defparam \macro_inst|adc2_latest[4]_reg .coord_x = 18;
defparam \macro_inst|adc2_latest[4]_reg .coord_y = 10;
defparam \macro_inst|adc2_latest[4]_reg .coord_z = 2;
defparam \macro_inst|adc2_latest[4]_reg .mask = 16'hFF00;
defparam \macro_inst|adc2_latest[4]_reg .modeMux = 1'b0;
defparam \macro_inst|adc2_latest[4]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_latest[4]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_latest[4]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc2_latest[4]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc2_latest[5]_reg (
	.A(\macro_inst|adc_clk_div [3]),
	.B(vcc),
	.C(\macro_inst|adc2_data [5]),
	.D(vcc),
	.Cin(\macro_inst|adc_clk_div_datab_0_cout [3]),
	.Qin(\macro_inst|adc2_latest [5]),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10001_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(SyncReset_X10001_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10001_Y10001_VCC),
	.LutOut(\macro_inst|adc_clk_div_datab_3_combout ),
	.Cout(\macro_inst|adc_clk_div_datab_0_cout [4]),
	.Q(\macro_inst|adc2_latest [5]));
defparam \macro_inst|adc2_latest[5]_reg .coord_x = 20;
defparam \macro_inst|adc2_latest[5]_reg .coord_y = 12;
defparam \macro_inst|adc2_latest[5]_reg .coord_z = 4;
defparam \macro_inst|adc2_latest[5]_reg .mask = 16'h69B2;
defparam \macro_inst|adc2_latest[5]_reg .modeMux = 1'b1;
defparam \macro_inst|adc2_latest[5]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_latest[5]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_latest[5]_reg .BypassEn = 1'b1;
defparam \macro_inst|adc2_latest[5]_reg .CarryEnb = 1'b0;

alta_slice \macro_inst|adc2_latest[6]_reg (
	.A(\macro_inst|adc_clk_div [1]),
	.B(vcc),
	.C(\macro_inst|adc2_data [6]),
	.D(vcc),
	.Cin(\macro_inst|adc_clk_div_datab_0_cout [1]),
	.Qin(\macro_inst|adc2_latest [6]),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10001_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(SyncReset_X10001_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10001_Y10001_VCC),
	.LutOut(\macro_inst|adc_clk_div_datab_1_combout ),
	.Cout(\macro_inst|adc_clk_div_datab_0_cout [2]),
	.Q(\macro_inst|adc2_latest [6]));
defparam \macro_inst|adc2_latest[6]_reg .coord_x = 20;
defparam \macro_inst|adc2_latest[6]_reg .coord_y = 12;
defparam \macro_inst|adc2_latest[6]_reg .coord_z = 2;
defparam \macro_inst|adc2_latest[6]_reg .mask = 16'h69B2;
defparam \macro_inst|adc2_latest[6]_reg .modeMux = 1'b1;
defparam \macro_inst|adc2_latest[6]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_latest[6]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_latest[6]_reg .BypassEn = 1'b1;
defparam \macro_inst|adc2_latest[6]_reg .CarryEnb = 1'b0;

alta_slice \macro_inst|adc2_latest[7]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc2_data [7]),
	.Cin(),
	.Qin(\macro_inst|adc2_latest [7]),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10006_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10006_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest[7]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc2_latest [7]));
defparam \macro_inst|adc2_latest[7]_reg .coord_x = 18;
defparam \macro_inst|adc2_latest[7]_reg .coord_y = 10;
defparam \macro_inst|adc2_latest[7]_reg .coord_z = 3;
defparam \macro_inst|adc2_latest[7]_reg .mask = 16'hFF00;
defparam \macro_inst|adc2_latest[7]_reg .modeMux = 1'b0;
defparam \macro_inst|adc2_latest[7]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_latest[7]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_latest[7]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc2_latest[7]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc2_latest[8]_reg (
	.A(vcc),
	.B(\macro_inst|adc_clk_div [2]),
	.C(\macro_inst|adc2_data [8]),
	.D(vcc),
	.Cin(\macro_inst|adc_clk_div_datab_0_cout [2]),
	.Qin(\macro_inst|adc2_latest [8]),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10001_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(SyncReset_X10001_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10001_Y10001_VCC),
	.LutOut(\macro_inst|adc_clk_div_datab_2_combout ),
	.Cout(\macro_inst|adc_clk_div_datab_0_cout [3]),
	.Q(\macro_inst|adc2_latest [8]));
defparam \macro_inst|adc2_latest[8]_reg .coord_x = 20;
defparam \macro_inst|adc2_latest[8]_reg .coord_y = 12;
defparam \macro_inst|adc2_latest[8]_reg .coord_z = 3;
defparam \macro_inst|adc2_latest[8]_reg .mask = 16'h69D4;
defparam \macro_inst|adc2_latest[8]_reg .modeMux = 1'b1;
defparam \macro_inst|adc2_latest[8]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_latest[8]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_latest[8]_reg .BypassEn = 1'b1;
defparam \macro_inst|adc2_latest[8]_reg .CarryEnb = 1'b0;

alta_slice \macro_inst|adc2_latest[9]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|adc2_data [9]),
	.Cin(),
	.Qin(\macro_inst|adc2_latest [9]),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10006_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10006_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest[9]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc2_latest [9]));
defparam \macro_inst|adc2_latest[9]_reg .coord_x = 18;
defparam \macro_inst|adc2_latest[9]_reg .coord_y = 10;
defparam \macro_inst|adc2_latest[9]_reg .coord_z = 11;
defparam \macro_inst|adc2_latest[9]_reg .mask = 16'hFF00;
defparam \macro_inst|adc2_latest[9]_reg .modeMux = 1'b0;
defparam \macro_inst|adc2_latest[9]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_latest[9]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_latest[9]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc2_latest[9]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc2_valid_reg (
	.A(),
	.B(),
	.C(),
	.D(vcc),
	.Cin(),
	.Qin(\macro_inst|adc2_valid ),
	.Clk(\bus_clk__macro_inst|adc2_eoc_d_A_Y_X10005_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10005_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_valid_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|adc2_valid ));
defparam \macro_inst|adc2_valid_reg .coord_x = 18;
defparam \macro_inst|adc2_valid_reg .coord_y = 12;
defparam \macro_inst|adc2_valid_reg .coord_z = 1;
defparam \macro_inst|adc2_valid_reg .mask = 16'hFF00;
defparam \macro_inst|adc2_valid_reg .modeMux = 1'b0;
defparam \macro_inst|adc2_valid_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc2_valid_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc2_valid_reg .BypassEn = 1'b0;
defparam \macro_inst|adc2_valid_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc_clk_div[0]_reg (
	.A(vcc),
	.B(\macro_inst|adc_clk_div_datab_0_combout ),
	.C(vcc),
	.D(\macro_inst|adc_clk_div_dataa_1_combout ),
	.Cin(),
	.Qin(\macro_inst|adc_clk_div [0]),
	.Clk(bus_clk_X10001_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc_clk_div_datab_0_combout_A_Y ),
	.Cout(),
	.Q(\macro_inst|adc_clk_div [0]));
defparam \macro_inst|adc_clk_div[0]_reg .coord_x = 20;
defparam \macro_inst|adc_clk_div[0]_reg .coord_y = 12;
defparam \macro_inst|adc_clk_div[0]_reg .coord_z = 8;
defparam \macro_inst|adc_clk_div[0]_reg .mask = 16'h00CC;
defparam \macro_inst|adc_clk_div[0]_reg .modeMux = 1'b0;
defparam \macro_inst|adc_clk_div[0]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc_clk_div[0]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc_clk_div[0]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc_clk_div[0]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc_clk_div[1]_reg (
	.A(vcc),
	.B(vcc),
	.C(\macro_inst|adc_clk_div_datab_1_combout ),
	.D(\macro_inst|adc_clk_div_dataa_1_combout ),
	.Cin(),
	.Qin(\macro_inst|adc_clk_div [1]),
	.Clk(bus_clk_X10001_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc_clk_div_datab_1_combout_A_Y ),
	.Cout(),
	.Q(\macro_inst|adc_clk_div [1]));
defparam \macro_inst|adc_clk_div[1]_reg .coord_x = 20;
defparam \macro_inst|adc_clk_div[1]_reg .coord_y = 12;
defparam \macro_inst|adc_clk_div[1]_reg .coord_z = 6;
defparam \macro_inst|adc_clk_div[1]_reg .mask = 16'h00F0;
defparam \macro_inst|adc_clk_div[1]_reg .modeMux = 1'b0;
defparam \macro_inst|adc_clk_div[1]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc_clk_div[1]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc_clk_div[1]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc_clk_div[1]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc_clk_div[2]_reg (
	.A(vcc),
	.B(\macro_inst|adc_clk_div_datab_2_combout ),
	.C(vcc),
	.D(\macro_inst|adc_clk_div_dataa_1_combout ),
	.Cin(),
	.Qin(\macro_inst|adc_clk_div [2]),
	.Clk(bus_clk_X10001_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc_clk_div_datab_2_combout_A_Y ),
	.Cout(),
	.Q(\macro_inst|adc_clk_div [2]));
defparam \macro_inst|adc_clk_div[2]_reg .coord_x = 20;
defparam \macro_inst|adc_clk_div[2]_reg .coord_y = 12;
defparam \macro_inst|adc_clk_div[2]_reg .coord_z = 7;
defparam \macro_inst|adc_clk_div[2]_reg .mask = 16'h00CC;
defparam \macro_inst|adc_clk_div[2]_reg .modeMux = 1'b0;
defparam \macro_inst|adc_clk_div[2]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc_clk_div[2]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc_clk_div[2]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc_clk_div[2]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc_clk_div[3]_reg (
	.A(vcc),
	.B(vcc),
	.C(\macro_inst|adc_clk_div_datab_3_combout ),
	.D(\macro_inst|adc_clk_div_dataa_1_combout ),
	.Cin(),
	.Qin(\macro_inst|adc_clk_div [3]),
	.Clk(bus_clk_X10001_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc_clk_div_datab_3_combout_A_Y ),
	.Cout(),
	.Q(\macro_inst|adc_clk_div [3]));
defparam \macro_inst|adc_clk_div[3]_reg .coord_x = 20;
defparam \macro_inst|adc_clk_div[3]_reg .coord_y = 12;
defparam \macro_inst|adc_clk_div[3]_reg .coord_z = 0;
defparam \macro_inst|adc_clk_div[3]_reg .mask = 16'h00F0;
defparam \macro_inst|adc_clk_div[3]_reg .modeMux = 1'b0;
defparam \macro_inst|adc_clk_div[3]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|adc_clk_div[3]_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc_clk_div[3]_reg .BypassEn = 1'b0;
defparam \macro_inst|adc_clk_div[3]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|adc_clk_div_dataa_1 (
	.A(\macro_inst|adc_clk_div [0]),
	.B(\macro_inst|adc_clk_div [1]),
	.C(\macro_inst|adc_clk_div [3]),
	.D(\macro_inst|adc_clk_div [2]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc_clk_div_dataa_1_combout ),
	.Cout(),
	.Q());
defparam \macro_inst|adc_clk_div_dataa_1 .coord_x = 20;
defparam \macro_inst|adc_clk_div_dataa_1 .coord_y = 12;
defparam \macro_inst|adc_clk_div_dataa_1 .coord_z = 5;
defparam \macro_inst|adc_clk_div_dataa_1 .mask = 16'h0020;
defparam \macro_inst|adc_clk_div_dataa_1 .modeMux = 1'b0;
defparam \macro_inst|adc_clk_div_dataa_1 .FeedbackMux = 1'b0;
defparam \macro_inst|adc_clk_div_dataa_1 .ShiftMux = 1'b0;
defparam \macro_inst|adc_clk_div_dataa_1 .BypassEn = 1'b0;
defparam \macro_inst|adc_clk_div_dataa_1 .CarryEnb = 1'b1;

alta_slice \macro_inst|adc_sclk_reg (
	.A(vcc),
	.B(vcc),
	.C(vcc),
	.D(\macro_inst|adc_clk_div_dataa_1_combout ),
	.Cin(),
	.Qin(\macro_inst|adc_sclk ),
	.Clk(bus_clk_X10001_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10001_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc_sclk_A_Y ),
	.Cout(),
	.Q(\macro_inst|adc_sclk ));
defparam \macro_inst|adc_sclk_reg .coord_x = 20;
defparam \macro_inst|adc_sclk_reg .coord_y = 12;
defparam \macro_inst|adc_sclk_reg .coord_z = 9;
defparam \macro_inst|adc_sclk_reg .mask = 16'h0FF0;
defparam \macro_inst|adc_sclk_reg .modeMux = 1'b0;
defparam \macro_inst|adc_sclk_reg .FeedbackMux = 1'b1;
defparam \macro_inst|adc_sclk_reg .ShiftMux = 1'b0;
defparam \macro_inst|adc_sclk_reg .BypassEn = 1'b0;
defparam \macro_inst|adc_sclk_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_penable_B_Y_combout (
	.A(vcc),
	.B(\macro_inst|apb_psel ),
	.C(\macro_inst|apb_penable ),
	.D(\macro_inst|apb_pwrite ),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|apb_penable_B_Y ),
	.Cout(),
	.Q());
defparam \macro_inst|apb_penable_B_Y_combout .coord_x = 14;
defparam \macro_inst|apb_penable_B_Y_combout .coord_y = 12;
defparam \macro_inst|apb_penable_B_Y_combout .coord_z = 4;
defparam \macro_inst|apb_penable_B_Y_combout .mask = 16'h000C;
defparam \macro_inst|apb_penable_B_Y_combout .modeMux = 1'b0;
defparam \macro_inst|apb_penable_B_Y_combout .FeedbackMux = 1'b0;
defparam \macro_inst|apb_penable_B_Y_combout .ShiftMux = 1'b0;
defparam \macro_inst|apb_penable_B_Y_combout .BypassEn = 1'b0;
defparam \macro_inst|apb_penable_B_Y_combout .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_prdata[0]_reg (
	.A(\macro_inst|adc1_valid ),
	.B(\macro_inst|adc1_latest_dataa_0_combout ),
	.C(\macro_inst|apb_paddr [2]),
	.D(\macro_inst|apb_paddr [3]),
	.Cin(),
	.Qin(\macro_inst|apb_prdata [0]),
	.Clk(\bus_clk__macro_inst|apb_penable_B_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest_A_0_Y_A_Y ),
	.Cout(),
	.Q(\macro_inst|apb_prdata [0]));
defparam \macro_inst|apb_prdata[0]_reg .coord_x = 19;
defparam \macro_inst|apb_prdata[0]_reg .coord_y = 12;
defparam \macro_inst|apb_prdata[0]_reg .coord_z = 0;
defparam \macro_inst|apb_prdata[0]_reg .mask = 16'h333B;
defparam \macro_inst|apb_prdata[0]_reg .modeMux = 1'b0;
defparam \macro_inst|apb_prdata[0]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|apb_prdata[0]_reg .ShiftMux = 1'b0;
defparam \macro_inst|apb_prdata[0]_reg .BypassEn = 1'b0;
defparam \macro_inst|apb_prdata[0]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_prdata[10]_reg (
	.A(\macro_inst|apb_paddr [2]),
	.B(\macro_inst|apb_paddr [3]),
	.C(\macro_inst|adc1_latest [10]),
	.D(\macro_inst|adc2_latest [10]),
	.Cin(),
	.Qin(\macro_inst|apb_prdata [10]),
	.Clk(\bus_clk__macro_inst|apb_penable_B_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest_A_10_Y_A_Y ),
	.Cout(),
	.Q(\macro_inst|apb_prdata [10]));
defparam \macro_inst|apb_prdata[10]_reg .coord_x = 19;
defparam \macro_inst|apb_prdata[10]_reg .coord_y = 12;
defparam \macro_inst|apb_prdata[10]_reg .coord_z = 11;
defparam \macro_inst|apb_prdata[10]_reg .mask = 16'h6420;
defparam \macro_inst|apb_prdata[10]_reg .modeMux = 1'b0;
defparam \macro_inst|apb_prdata[10]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|apb_prdata[10]_reg .ShiftMux = 1'b0;
defparam \macro_inst|apb_prdata[10]_reg .BypassEn = 1'b0;
defparam \macro_inst|apb_prdata[10]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_prdata[11]_reg (
	.A(\macro_inst|adc2_latest [11]),
	.B(\macro_inst|adc1_latest [11]),
	.C(\macro_inst|apb_paddr [2]),
	.D(\macro_inst|apb_paddr [3]),
	.Cin(),
	.Qin(\macro_inst|apb_prdata [11]),
	.Clk(\bus_clk__macro_inst|apb_penable_B_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest_A_11_Y_A_Y ),
	.Cout(),
	.Q(\macro_inst|apb_prdata [11]));
defparam \macro_inst|apb_prdata[11]_reg .coord_x = 19;
defparam \macro_inst|apb_prdata[11]_reg .coord_y = 12;
defparam \macro_inst|apb_prdata[11]_reg .coord_z = 12;
defparam \macro_inst|apb_prdata[11]_reg .mask = 16'h0AC0;
defparam \macro_inst|apb_prdata[11]_reg .modeMux = 1'b0;
defparam \macro_inst|apb_prdata[11]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|apb_prdata[11]_reg .ShiftMux = 1'b0;
defparam \macro_inst|apb_prdata[11]_reg .BypassEn = 1'b0;
defparam \macro_inst|apb_prdata[11]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_prdata[1]_reg (
	.A(\macro_inst|adc2_valid ),
	.B(\macro_inst|adc1_latest_dataa_1_combout ),
	.C(\macro_inst|apb_paddr [2]),
	.D(\macro_inst|apb_paddr [3]),
	.Cin(),
	.Qin(\macro_inst|apb_prdata [1]),
	.Clk(\bus_clk__macro_inst|apb_penable_B_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc1_latest_A_1_Y_A_Y ),
	.Cout(),
	.Q(\macro_inst|apb_prdata [1]));
defparam \macro_inst|apb_prdata[1]_reg .coord_x = 19;
defparam \macro_inst|apb_prdata[1]_reg .coord_y = 12;
defparam \macro_inst|apb_prdata[1]_reg .coord_z = 6;
defparam \macro_inst|apb_prdata[1]_reg .mask = 16'h333B;
defparam \macro_inst|apb_prdata[1]_reg .modeMux = 1'b0;
defparam \macro_inst|apb_prdata[1]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|apb_prdata[1]_reg .ShiftMux = 1'b0;
defparam \macro_inst|apb_prdata[1]_reg .BypassEn = 1'b0;
defparam \macro_inst|apb_prdata[1]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_prdata[2]_reg (
	.A(\macro_inst|adc2_latest [2]),
	.B(\macro_inst|adc1_latest [2]),
	.C(\macro_inst|apb_paddr [2]),
	.D(\macro_inst|apb_paddr [3]),
	.Cin(),
	.Qin(\macro_inst|apb_prdata [2]),
	.Clk(\bus_clk__macro_inst|apb_penable_B_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest_A_2_Y_A_Y ),
	.Cout(),
	.Q(\macro_inst|apb_prdata [2]));
defparam \macro_inst|apb_prdata[2]_reg .coord_x = 19;
defparam \macro_inst|apb_prdata[2]_reg .coord_y = 12;
defparam \macro_inst|apb_prdata[2]_reg .coord_z = 10;
defparam \macro_inst|apb_prdata[2]_reg .mask = 16'h0AC0;
defparam \macro_inst|apb_prdata[2]_reg .modeMux = 1'b0;
defparam \macro_inst|apb_prdata[2]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|apb_prdata[2]_reg .ShiftMux = 1'b0;
defparam \macro_inst|apb_prdata[2]_reg .BypassEn = 1'b0;
defparam \macro_inst|apb_prdata[2]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_prdata[3]_reg (
	.A(\macro_inst|apb_paddr [2]),
	.B(\macro_inst|adc2_latest [3]),
	.C(\macro_inst|adc1_latest [3]),
	.D(\macro_inst|apb_paddr [3]),
	.Cin(),
	.Qin(\macro_inst|apb_prdata [3]),
	.Clk(\bus_clk__macro_inst|apb_penable_B_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest_A_3_Y_A_Y ),
	.Cout(),
	.Q(\macro_inst|apb_prdata [3]));
defparam \macro_inst|apb_prdata[3]_reg .coord_x = 19;
defparam \macro_inst|apb_prdata[3]_reg .coord_y = 12;
defparam \macro_inst|apb_prdata[3]_reg .coord_z = 9;
defparam \macro_inst|apb_prdata[3]_reg .mask = 16'h44A0;
defparam \macro_inst|apb_prdata[3]_reg .modeMux = 1'b0;
defparam \macro_inst|apb_prdata[3]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|apb_prdata[3]_reg .ShiftMux = 1'b0;
defparam \macro_inst|apb_prdata[3]_reg .BypassEn = 1'b0;
defparam \macro_inst|apb_prdata[3]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_prdata[4]_reg (
	.A(\macro_inst|adc1_latest [4]),
	.B(\macro_inst|adc2_latest [4]),
	.C(\macro_inst|apb_paddr [2]),
	.D(\macro_inst|apb_paddr [3]),
	.Cin(),
	.Qin(\macro_inst|apb_prdata [4]),
	.Clk(\bus_clk__macro_inst|apb_penable_B_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest_A_4_Y_A_Y ),
	.Cout(),
	.Q(\macro_inst|apb_prdata [4]));
defparam \macro_inst|apb_prdata[4]_reg .coord_x = 19;
defparam \macro_inst|apb_prdata[4]_reg .coord_y = 12;
defparam \macro_inst|apb_prdata[4]_reg .coord_z = 4;
defparam \macro_inst|apb_prdata[4]_reg .mask = 16'h0CA0;
defparam \macro_inst|apb_prdata[4]_reg .modeMux = 1'b0;
defparam \macro_inst|apb_prdata[4]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|apb_prdata[4]_reg .ShiftMux = 1'b0;
defparam \macro_inst|apb_prdata[4]_reg .BypassEn = 1'b0;
defparam \macro_inst|apb_prdata[4]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_prdata[5]_reg (
	.A(\macro_inst|adc2_latest [5]),
	.B(\macro_inst|adc1_latest [5]),
	.C(\macro_inst|apb_paddr [2]),
	.D(\macro_inst|apb_paddr [3]),
	.Cin(),
	.Qin(\macro_inst|apb_prdata [5]),
	.Clk(\bus_clk__macro_inst|apb_penable_B_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest_A_5_Y_A_Y ),
	.Cout(),
	.Q(\macro_inst|apb_prdata [5]));
defparam \macro_inst|apb_prdata[5]_reg .coord_x = 19;
defparam \macro_inst|apb_prdata[5]_reg .coord_y = 12;
defparam \macro_inst|apb_prdata[5]_reg .coord_z = 15;
defparam \macro_inst|apb_prdata[5]_reg .mask = 16'h0AC0;
defparam \macro_inst|apb_prdata[5]_reg .modeMux = 1'b0;
defparam \macro_inst|apb_prdata[5]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|apb_prdata[5]_reg .ShiftMux = 1'b0;
defparam \macro_inst|apb_prdata[5]_reg .BypassEn = 1'b0;
defparam \macro_inst|apb_prdata[5]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_prdata[6]_reg (
	.A(\macro_inst|apb_paddr [3]),
	.B(\macro_inst|adc2_latest [6]),
	.C(\macro_inst|apb_paddr [2]),
	.D(\macro_inst|adc1_latest [6]),
	.Cin(),
	.Qin(\macro_inst|apb_prdata [6]),
	.Clk(\bus_clk__macro_inst|apb_penable_B_Y_X10006_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10006_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest_A_6_Y_A_Y ),
	.Cout(),
	.Q(\macro_inst|apb_prdata [6]));
defparam \macro_inst|apb_prdata[6]_reg .coord_x = 18;
defparam \macro_inst|apb_prdata[6]_reg .coord_y = 10;
defparam \macro_inst|apb_prdata[6]_reg .coord_z = 5;
defparam \macro_inst|apb_prdata[6]_reg .mask = 16'h5808;
defparam \macro_inst|apb_prdata[6]_reg .modeMux = 1'b0;
defparam \macro_inst|apb_prdata[6]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|apb_prdata[6]_reg .ShiftMux = 1'b0;
defparam \macro_inst|apb_prdata[6]_reg .BypassEn = 1'b0;
defparam \macro_inst|apb_prdata[6]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_prdata[7]_reg (
	.A(\macro_inst|apb_paddr [2]),
	.B(\macro_inst|adc1_latest [7]),
	.C(\macro_inst|apb_paddr [3]),
	.D(\macro_inst|adc2_latest [7]),
	.Cin(),
	.Qin(\macro_inst|apb_prdata [7]),
	.Clk(\bus_clk__macro_inst|apb_penable_B_Y_X10006_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10006_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest_A_7_Y_A_Y ),
	.Cout(),
	.Q(\macro_inst|apb_prdata [7]));
defparam \macro_inst|apb_prdata[7]_reg .coord_x = 18;
defparam \macro_inst|apb_prdata[7]_reg .coord_y = 10;
defparam \macro_inst|apb_prdata[7]_reg .coord_z = 0;
defparam \macro_inst|apb_prdata[7]_reg .mask = 16'h5808;
defparam \macro_inst|apb_prdata[7]_reg .modeMux = 1'b0;
defparam \macro_inst|apb_prdata[7]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|apb_prdata[7]_reg .ShiftMux = 1'b0;
defparam \macro_inst|apb_prdata[7]_reg .BypassEn = 1'b0;
defparam \macro_inst|apb_prdata[7]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_prdata[8]_reg (
	.A(\macro_inst|adc2_latest [8]),
	.B(\macro_inst|adc1_latest [8]),
	.C(\macro_inst|apb_paddr [2]),
	.D(\macro_inst|apb_paddr [3]),
	.Cin(),
	.Qin(\macro_inst|apb_prdata [8]),
	.Clk(\bus_clk__macro_inst|apb_penable_B_Y_X10002_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10002_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest_A_8_Y_A_Y ),
	.Cout(),
	.Q(\macro_inst|apb_prdata [8]));
defparam \macro_inst|apb_prdata[8]_reg .coord_x = 19;
defparam \macro_inst|apb_prdata[8]_reg .coord_y = 12;
defparam \macro_inst|apb_prdata[8]_reg .coord_z = 13;
defparam \macro_inst|apb_prdata[8]_reg .mask = 16'h0AC0;
defparam \macro_inst|apb_prdata[8]_reg .modeMux = 1'b0;
defparam \macro_inst|apb_prdata[8]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|apb_prdata[8]_reg .ShiftMux = 1'b0;
defparam \macro_inst|apb_prdata[8]_reg .BypassEn = 1'b0;
defparam \macro_inst|apb_prdata[8]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|apb_prdata[9]_reg (
	.A(\macro_inst|adc1_latest [9]),
	.B(\macro_inst|adc2_latest [9]),
	.C(\macro_inst|apb_paddr [3]),
	.D(\macro_inst|apb_paddr [2]),
	.Cin(),
	.Qin(\macro_inst|apb_prdata [9]),
	.Clk(\bus_clk__macro_inst|apb_penable_B_Y_X10006_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10006_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|adc2_latest_A_9_Y_A_Y ),
	.Cout(),
	.Q(\macro_inst|apb_prdata [9]));
defparam \macro_inst|apb_prdata[9]_reg .coord_x = 18;
defparam \macro_inst|apb_prdata[9]_reg .coord_y = 10;
defparam \macro_inst|apb_prdata[9]_reg .coord_z = 4;
defparam \macro_inst|apb_prdata[9]_reg .mask = 16'h0AC0;
defparam \macro_inst|apb_prdata[9]_reg .modeMux = 1'b0;
defparam \macro_inst|apb_prdata[9]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|apb_prdata[9]_reg .ShiftMux = 1'b0;
defparam \macro_inst|apb_prdata[9]_reg .BypassEn = 1'b0;
defparam \macro_inst|apb_prdata[9]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|ahb_htrans_B_1_Y_combout (
	.A(vcc),
	.B(\macro_inst|bridge|hreadyout_reg_q ),
	.C(vcc),
	.D(\macro_inst|bridge|ahb_htrans [1]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|ahb_htrans_B_1_Y ),
	.Cout(),
	.Q());
defparam \macro_inst|bridge|ahb_htrans_B_1_Y_combout .coord_x = 14;
defparam \macro_inst|bridge|ahb_htrans_B_1_Y_combout .coord_y = 12;
defparam \macro_inst|bridge|ahb_htrans_B_1_Y_combout .coord_z = 6;
defparam \macro_inst|bridge|ahb_htrans_B_1_Y_combout .mask = 16'h3300;
defparam \macro_inst|bridge|ahb_htrans_B_1_Y_combout .modeMux = 1'b0;
defparam \macro_inst|bridge|ahb_htrans_B_1_Y_combout .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|ahb_htrans_B_1_Y_combout .ShiftMux = 1'b0;
defparam \macro_inst|bridge|ahb_htrans_B_1_Y_combout .BypassEn = 1'b0;
defparam \macro_inst|bridge|ahb_htrans_B_1_Y_combout .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|apbState[0]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|bridge|pvalid_A_1_Y_A_Y ),
	.Cin(),
	.Qin(\macro_inst|bridge|apbState[0]_reg_q ),
	.Clk(bus_clk_X10004_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10004_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|pvalid_A_1_Y_A_Y_inv ),
	.Cout(),
	.Q(\macro_inst|bridge|apbState[0]_reg_q ));
defparam \macro_inst|bridge|apbState[0]_reg .coord_x = 15;
defparam \macro_inst|bridge|apbState[0]_reg .coord_y = 12;
defparam \macro_inst|bridge|apbState[0]_reg .coord_z = 7;
defparam \macro_inst|bridge|apbState[0]_reg .mask = 16'h00FF;
defparam \macro_inst|bridge|apbState[0]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|apbState[0]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|apbState[0]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|apbState[0]_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|apbState[0]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|apbState[1]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|bridge|apbState [2]),
	.Cin(),
	.Qin(\macro_inst|bridge|apbState [1]),
	.Clk(bus_clk_X10003_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10003_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|apbState[1]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|bridge|apbState [1]));
defparam \macro_inst|bridge|apbState[1]_reg .coord_x = 14;
defparam \macro_inst|bridge|apbState[1]_reg .coord_y = 12;
defparam \macro_inst|bridge|apbState[1]_reg .coord_z = 13;
defparam \macro_inst|bridge|apbState[1]_reg .mask = 16'hFF00;
defparam \macro_inst|bridge|apbState[1]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|apbState[1]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|apbState[1]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|apbState[1]_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|apbState[1]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|apbState[2]_reg (
	.A(vcc),
	.B(\macro_inst|bridge|apbState [1]),
	.C(\macro_inst|bridge|apbState[0]_reg_q ),
	.D(\macro_inst|bridge|pvalid ),
	.Cin(),
	.Qin(\macro_inst|bridge|apbState [2]),
	.Clk(bus_clk_X10003_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10003_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|pvalid_A_Y ),
	.Cout(),
	.Q(\macro_inst|bridge|apbState [2]));
defparam \macro_inst|bridge|apbState[2]_reg .coord_x = 14;
defparam \macro_inst|bridge|apbState[2]_reg .coord_y = 12;
defparam \macro_inst|bridge|apbState[2]_reg .coord_z = 1;
defparam \macro_inst|bridge|apbState[2]_reg .mask = 16'hCF00;
defparam \macro_inst|bridge|apbState[2]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|apbState[2]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|apbState[2]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|apbState[2]_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|apbState[2]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|haddr[2]_reg (
	.A(),
	.B(),
	.C(\macro_inst|mem_ahb_haddr [2]),
	.D(),
	.Cin(),
	.Qin(\macro_inst|bridge|haddr [2]),
	.Clk(bus_clk_X10003_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10003_Y10001_INV),
	.SyncReset(SyncReset_X10003_Y10001_GND),
	.ShiftData(),
	.SyncLoad(\macro_inst|bridge|ahb_htrans_B_1_Y__SyncLoad_X10003_Y10001_SIG ),
	.LutOut(\macro_inst|bridge|haddr[2]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|bridge|haddr [2]));
defparam \macro_inst|bridge|haddr[2]_reg .coord_x = 14;
defparam \macro_inst|bridge|haddr[2]_reg .coord_y = 12;
defparam \macro_inst|bridge|haddr[2]_reg .coord_z = 2;
defparam \macro_inst|bridge|haddr[2]_reg .mask = 16'hF0F0;
defparam \macro_inst|bridge|haddr[2]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|haddr[2]_reg .FeedbackMux = 1'b1;
defparam \macro_inst|bridge|haddr[2]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|haddr[2]_reg .BypassEn = 1'b1;
defparam \macro_inst|bridge|haddr[2]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|haddr[3]_reg (
	.A(),
	.B(),
	.C(\macro_inst|mem_ahb_haddr [3]),
	.D(),
	.Cin(),
	.Qin(\macro_inst|bridge|haddr [3]),
	.Clk(bus_clk_X10003_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10003_Y10001_INV),
	.SyncReset(SyncReset_X10003_Y10001_GND),
	.ShiftData(),
	.SyncLoad(\macro_inst|bridge|ahb_htrans_B_1_Y__SyncLoad_X10003_Y10001_SIG ),
	.LutOut(\macro_inst|bridge|haddr[3]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|bridge|haddr [3]));
defparam \macro_inst|bridge|haddr[3]_reg .coord_x = 14;
defparam \macro_inst|bridge|haddr[3]_reg .coord_y = 12;
defparam \macro_inst|bridge|haddr[3]_reg .coord_z = 14;
defparam \macro_inst|bridge|haddr[3]_reg .mask = 16'hF0F0;
defparam \macro_inst|bridge|haddr[3]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|haddr[3]_reg .FeedbackMux = 1'b1;
defparam \macro_inst|bridge|haddr[3]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|haddr[3]_reg .BypassEn = 1'b1;
defparam \macro_inst|bridge|haddr[3]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|hdone_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|bridge|ahb_hreadyout_A_Y ),
	.Cin(),
	.Qin(\macro_inst|bridge|hdone_reg_q ),
	.Clk(bus_clk_X10004_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10004_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|ahb_hreadyout_A_Y_inv ),
	.Cout(),
	.Q(\macro_inst|bridge|hdone_reg_q ));
defparam \macro_inst|bridge|hdone_reg .coord_x = 15;
defparam \macro_inst|bridge|hdone_reg .coord_y = 12;
defparam \macro_inst|bridge|hdone_reg .coord_z = 11;
defparam \macro_inst|bridge|hdone_reg .mask = 16'h00FF;
defparam \macro_inst|bridge|hdone_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|hdone_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|hdone_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|hdone_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|hdone_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|hreadyout_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|bridge|hreadyout_reg_q_S_Y ),
	.Cin(),
	.Qin(\macro_inst|bridge|hreadyout_reg_q ),
	.Clk(bus_clk_X10003_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10003_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|hreadyout_reg_q_S_Y_inv ),
	.Cout(),
	.Q(\macro_inst|bridge|hreadyout_reg_q ));
defparam \macro_inst|bridge|hreadyout_reg .coord_x = 14;
defparam \macro_inst|bridge|hreadyout_reg .coord_y = 12;
defparam \macro_inst|bridge|hreadyout_reg .coord_z = 3;
defparam \macro_inst|bridge|hreadyout_reg .mask = 16'h00FF;
defparam \macro_inst|bridge|hreadyout_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|hreadyout_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|hreadyout_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|hreadyout_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|hreadyout_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|hreadyout_reg_q_S_Y_combout (
	.A(\macro_inst|bridge|hdone_reg_q ),
	.B(\macro_inst|bridge|hreadyout_reg_q ),
	.C(\macro_inst|bridge|pdone ),
	.D(\macro_inst|bridge|ahb_htrans [1]),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|hreadyout_reg_q_S_Y ),
	.Cout(),
	.Q());
defparam \macro_inst|bridge|hreadyout_reg_q_S_Y_combout .coord_x = 14;
defparam \macro_inst|bridge|hreadyout_reg_q_S_Y_combout .coord_y = 12;
defparam \macro_inst|bridge|hreadyout_reg_q_S_Y_combout .coord_z = 5;
defparam \macro_inst|bridge|hreadyout_reg_q_S_Y_combout .mask = 16'h80B3;
defparam \macro_inst|bridge|hreadyout_reg_q_S_Y_combout .modeMux = 1'b0;
defparam \macro_inst|bridge|hreadyout_reg_q_S_Y_combout .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|hreadyout_reg_q_S_Y_combout .ShiftMux = 1'b0;
defparam \macro_inst|bridge|hreadyout_reg_q_S_Y_combout .BypassEn = 1'b0;
defparam \macro_inst|bridge|hreadyout_reg_q_S_Y_combout .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|hwrite_reg (
	.A(),
	.B(),
	.C(\macro_inst|bridge|ahb_hwrite ),
	.D(),
	.Cin(),
	.Qin(\macro_inst|bridge|hwrite ),
	.Clk(bus_clk_X10003_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10003_Y10001_INV),
	.SyncReset(SyncReset_X10003_Y10001_GND),
	.ShiftData(),
	.SyncLoad(\macro_inst|bridge|ahb_htrans_B_1_Y__SyncLoad_X10003_Y10001_SIG ),
	.LutOut(\macro_inst|bridge|hwrite_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|bridge|hwrite ));
defparam \macro_inst|bridge|hwrite_reg .coord_x = 14;
defparam \macro_inst|bridge|hwrite_reg .coord_y = 12;
defparam \macro_inst|bridge|hwrite_reg .coord_z = 0;
defparam \macro_inst|bridge|hwrite_reg .mask = 16'hF0F0;
defparam \macro_inst|bridge|hwrite_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|hwrite_reg .FeedbackMux = 1'b1;
defparam \macro_inst|bridge|hwrite_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|hwrite_reg .BypassEn = 1'b1;
defparam \macro_inst|bridge|hwrite_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|paddr[2]_reg (
	.A(),
	.B(),
	.C(\macro_inst|bridge|haddr [2]),
	.D(),
	.Cin(),
	.Qin(\macro_inst|apb_paddr [2]),
	.Clk(bus_clk_X10005_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10005_Y10001_INV),
	.SyncReset(SyncReset_X10005_Y10001_GND),
	.ShiftData(),
	.SyncLoad(\macro_inst|bridge|pvalid_A_Y__SyncLoad_X10005_Y10001_SIG ),
	.LutOut(\macro_inst|bridge|paddr[2]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|apb_paddr [2]));
defparam \macro_inst|bridge|paddr[2]_reg .coord_x = 18;
defparam \macro_inst|bridge|paddr[2]_reg .coord_y = 12;
defparam \macro_inst|bridge|paddr[2]_reg .coord_z = 3;
defparam \macro_inst|bridge|paddr[2]_reg .mask = 16'hF0F0;
defparam \macro_inst|bridge|paddr[2]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|paddr[2]_reg .FeedbackMux = 1'b1;
defparam \macro_inst|bridge|paddr[2]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|paddr[2]_reg .BypassEn = 1'b1;
defparam \macro_inst|bridge|paddr[2]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|paddr[3]_reg (
	.A(),
	.B(),
	.C(\macro_inst|bridge|haddr [3]),
	.D(),
	.Cin(),
	.Qin(\macro_inst|apb_paddr [3]),
	.Clk(bus_clk_X10005_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10005_Y10001_INV),
	.SyncReset(SyncReset_X10005_Y10001_GND),
	.ShiftData(),
	.SyncLoad(\macro_inst|bridge|pvalid_A_Y__SyncLoad_X10005_Y10001_SIG ),
	.LutOut(\macro_inst|bridge|paddr[3]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|apb_paddr [3]));
defparam \macro_inst|bridge|paddr[3]_reg .coord_x = 18;
defparam \macro_inst|bridge|paddr[3]_reg .coord_y = 12;
defparam \macro_inst|bridge|paddr[3]_reg .coord_z = 2;
defparam \macro_inst|bridge|paddr[3]_reg .mask = 16'hF0F0;
defparam \macro_inst|bridge|paddr[3]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|paddr[3]_reg .FeedbackMux = 1'b1;
defparam \macro_inst|bridge|paddr[3]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|paddr[3]_reg .BypassEn = 1'b1;
defparam \macro_inst|bridge|paddr[3]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|pdone_reg (
	.A(vcc),
	.B(vcc),
	.C(vcc),
	.D(\macro_inst|bridge|apb_pdone ),
	.Cin(),
	.Qin(\macro_inst|bridge|pdone ),
	.Clk(bus_clk_X10004_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10004_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|pdone_B_1_Y ),
	.Cout(),
	.Q(\macro_inst|bridge|pdone ));
defparam \macro_inst|bridge|pdone_reg .coord_x = 15;
defparam \macro_inst|bridge|pdone_reg .coord_y = 12;
defparam \macro_inst|bridge|pdone_reg .coord_z = 1;
defparam \macro_inst|bridge|pdone_reg .mask = 16'h0F00;
defparam \macro_inst|bridge|pdone_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|pdone_reg .FeedbackMux = 1'b1;
defparam \macro_inst|bridge|pdone_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|pdone_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|pdone_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|penable_reg (
	.A(vcc),
	.B(\macro_inst|bridge|apbState [2]),
	.C(vcc),
	.D(\macro_inst|bridge|apbState [1]),
	.Cin(),
	.Qin(\macro_inst|apb_penable ),
	.Clk(bus_clk_X10004_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10004_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|apbState_A_1_Y ),
	.Cout(),
	.Q(\macro_inst|apb_penable ));
defparam \macro_inst|bridge|penable_reg .coord_x = 15;
defparam \macro_inst|bridge|penable_reg .coord_y = 12;
defparam \macro_inst|bridge|penable_reg .coord_z = 2;
defparam \macro_inst|bridge|penable_reg .mask = 16'h00FC;
defparam \macro_inst|bridge|penable_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|penable_reg .FeedbackMux = 1'b1;
defparam \macro_inst|bridge|penable_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|penable_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|penable_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|prdata[0]_reg (
	.A(),
	.B(),
	.C(\macro_inst|apb_prdata [0]),
	.D(),
	.Cin(),
	.Qin(\macro_inst|bridge|ahb_hrdata [0]),
	.Clk(\bus_clk__macro_inst|bridge|apb_pdone_X10004_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10004_Y10001_INV),
	.SyncReset(SyncReset_X10004_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10004_Y10001_VCC),
	.LutOut(),
	.Cout(),
	.Q(\macro_inst|bridge|ahb_hrdata [0]));
defparam \macro_inst|bridge|prdata[0]_reg .coord_x = 15;
defparam \macro_inst|bridge|prdata[0]_reg .coord_y = 12;
defparam \macro_inst|bridge|prdata[0]_reg .coord_z = 10;
defparam \macro_inst|bridge|prdata[0]_reg .mask = 16'hFFFF;
defparam \macro_inst|bridge|prdata[0]_reg .modeMux = 1'b1;
defparam \macro_inst|bridge|prdata[0]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|prdata[0]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|prdata[0]_reg .BypassEn = 1'b1;
defparam \macro_inst|bridge|prdata[0]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|prdata[10]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|apb_prdata [10]),
	.Cin(),
	.Qin(\macro_inst|bridge|ahb_hrdata [10]),
	.Clk(\bus_clk__macro_inst|bridge|apb_pdone_X10003_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10003_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|prdata[10]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|bridge|ahb_hrdata [10]));
defparam \macro_inst|bridge|prdata[10]_reg .coord_x = 14;
defparam \macro_inst|bridge|prdata[10]_reg .coord_y = 12;
defparam \macro_inst|bridge|prdata[10]_reg .coord_z = 10;
defparam \macro_inst|bridge|prdata[10]_reg .mask = 16'hFF00;
defparam \macro_inst|bridge|prdata[10]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|prdata[10]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|prdata[10]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|prdata[10]_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|prdata[10]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|prdata[11]_reg (
	.A(),
	.B(),
	.C(\macro_inst|apb_prdata [11]),
	.D(),
	.Cin(),
	.Qin(\macro_inst|bridge|ahb_hrdata [11]),
	.Clk(\bus_clk__macro_inst|bridge|apb_pdone_X10004_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10004_Y10001_INV),
	.SyncReset(SyncReset_X10004_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10004_Y10001_VCC),
	.LutOut(),
	.Cout(),
	.Q(\macro_inst|bridge|ahb_hrdata [11]));
defparam \macro_inst|bridge|prdata[11]_reg .coord_x = 15;
defparam \macro_inst|bridge|prdata[11]_reg .coord_y = 12;
defparam \macro_inst|bridge|prdata[11]_reg .coord_z = 8;
defparam \macro_inst|bridge|prdata[11]_reg .mask = 16'hFFFF;
defparam \macro_inst|bridge|prdata[11]_reg .modeMux = 1'b1;
defparam \macro_inst|bridge|prdata[11]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|prdata[11]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|prdata[11]_reg .BypassEn = 1'b1;
defparam \macro_inst|bridge|prdata[11]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|prdata[1]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|apb_prdata [1]),
	.Cin(),
	.Qin(\macro_inst|bridge|ahb_hrdata [1]),
	.Clk(\bus_clk__macro_inst|bridge|apb_pdone_X10003_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10003_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|prdata[1]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|bridge|ahb_hrdata [1]));
defparam \macro_inst|bridge|prdata[1]_reg .coord_x = 14;
defparam \macro_inst|bridge|prdata[1]_reg .coord_y = 12;
defparam \macro_inst|bridge|prdata[1]_reg .coord_z = 12;
defparam \macro_inst|bridge|prdata[1]_reg .mask = 16'hFF00;
defparam \macro_inst|bridge|prdata[1]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|prdata[1]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|prdata[1]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|prdata[1]_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|prdata[1]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|prdata[2]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|apb_prdata [2]),
	.Cin(),
	.Qin(\macro_inst|bridge|ahb_hrdata [2]),
	.Clk(\bus_clk__macro_inst|bridge|apb_pdone_X10003_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10003_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|prdata[2]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|bridge|ahb_hrdata [2]));
defparam \macro_inst|bridge|prdata[2]_reg .coord_x = 14;
defparam \macro_inst|bridge|prdata[2]_reg .coord_y = 12;
defparam \macro_inst|bridge|prdata[2]_reg .coord_z = 8;
defparam \macro_inst|bridge|prdata[2]_reg .mask = 16'hFF00;
defparam \macro_inst|bridge|prdata[2]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|prdata[2]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|prdata[2]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|prdata[2]_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|prdata[2]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|prdata[3]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|apb_prdata [3]),
	.Cin(),
	.Qin(\macro_inst|bridge|ahb_hrdata [3]),
	.Clk(\bus_clk__macro_inst|bridge|apb_pdone_X10003_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10003_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|prdata[3]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|bridge|ahb_hrdata [3]));
defparam \macro_inst|bridge|prdata[3]_reg .coord_x = 14;
defparam \macro_inst|bridge|prdata[3]_reg .coord_y = 12;
defparam \macro_inst|bridge|prdata[3]_reg .coord_z = 7;
defparam \macro_inst|bridge|prdata[3]_reg .mask = 16'hFF00;
defparam \macro_inst|bridge|prdata[3]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|prdata[3]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|prdata[3]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|prdata[3]_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|prdata[3]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|prdata[4]_reg (
	.A(\macro_inst|bridge|pvalid ),
	.B(\macro_inst|bridge|hdone_reg_q ),
	.C(\macro_inst|apb_prdata [4]),
	.D(\macro_inst|bridge|hreadyout_reg_q ),
	.Cin(),
	.Qin(\macro_inst|bridge|ahb_hrdata [4]),
	.Clk(\bus_clk__macro_inst|bridge|apb_pdone_X10004_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10004_Y10001_INV),
	.SyncReset(SyncReset_X10004_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10004_Y10001_VCC),
	.LutOut(\macro_inst|bridge|ahb_hreadyout_A_Y ),
	.Cout(),
	.Q(\macro_inst|bridge|ahb_hrdata [4]));
defparam \macro_inst|bridge|prdata[4]_reg .coord_x = 15;
defparam \macro_inst|bridge|prdata[4]_reg .coord_y = 12;
defparam \macro_inst|bridge|prdata[4]_reg .coord_z = 5;
defparam \macro_inst|bridge|prdata[4]_reg .mask = 16'h11FF;
defparam \macro_inst|bridge|prdata[4]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|prdata[4]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|prdata[4]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|prdata[4]_reg .BypassEn = 1'b1;
defparam \macro_inst|bridge|prdata[4]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|prdata[5]_reg (
	.A(),
	.B(),
	.C(\macro_inst|apb_prdata [5]),
	.D(),
	.Cin(),
	.Qin(\macro_inst|bridge|ahb_hrdata [5]),
	.Clk(\bus_clk__macro_inst|bridge|apb_pdone_X10004_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10004_Y10001_INV),
	.SyncReset(SyncReset_X10004_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10004_Y10001_VCC),
	.LutOut(),
	.Cout(),
	.Q(\macro_inst|bridge|ahb_hrdata [5]));
defparam \macro_inst|bridge|prdata[5]_reg .coord_x = 15;
defparam \macro_inst|bridge|prdata[5]_reg .coord_y = 12;
defparam \macro_inst|bridge|prdata[5]_reg .coord_z = 9;
defparam \macro_inst|bridge|prdata[5]_reg .mask = 16'hFFFF;
defparam \macro_inst|bridge|prdata[5]_reg .modeMux = 1'b1;
defparam \macro_inst|bridge|prdata[5]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|prdata[5]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|prdata[5]_reg .BypassEn = 1'b1;
defparam \macro_inst|bridge|prdata[5]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|prdata[6]_reg (
	.A(),
	.B(),
	.C(\macro_inst|apb_prdata [6]),
	.D(),
	.Cin(),
	.Qin(\macro_inst|bridge|ahb_hrdata [6]),
	.Clk(\bus_clk__macro_inst|bridge|apb_pdone_X10004_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10004_Y10001_INV),
	.SyncReset(SyncReset_X10004_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10004_Y10001_VCC),
	.LutOut(),
	.Cout(),
	.Q(\macro_inst|bridge|ahb_hrdata [6]));
defparam \macro_inst|bridge|prdata[6]_reg .coord_x = 15;
defparam \macro_inst|bridge|prdata[6]_reg .coord_y = 12;
defparam \macro_inst|bridge|prdata[6]_reg .coord_z = 6;
defparam \macro_inst|bridge|prdata[6]_reg .mask = 16'hFFFF;
defparam \macro_inst|bridge|prdata[6]_reg .modeMux = 1'b1;
defparam \macro_inst|bridge|prdata[6]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|prdata[6]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|prdata[6]_reg .BypassEn = 1'b1;
defparam \macro_inst|bridge|prdata[6]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|prdata[7]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|apb_prdata [7]),
	.Cin(),
	.Qin(\macro_inst|bridge|ahb_hrdata [7]),
	.Clk(\bus_clk__macro_inst|bridge|apb_pdone_X10003_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10003_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|prdata[7]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|bridge|ahb_hrdata [7]));
defparam \macro_inst|bridge|prdata[7]_reg .coord_x = 14;
defparam \macro_inst|bridge|prdata[7]_reg .coord_y = 12;
defparam \macro_inst|bridge|prdata[7]_reg .coord_z = 9;
defparam \macro_inst|bridge|prdata[7]_reg .mask = 16'hFF00;
defparam \macro_inst|bridge|prdata[7]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|prdata[7]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|prdata[7]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|prdata[7]_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|prdata[7]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|prdata[8]_reg (
	.A(\macro_inst|apb_psel ),
	.B(vcc),
	.C(\macro_inst|apb_prdata [8]),
	.D(\macro_inst|apb_penable ),
	.Cin(),
	.Qin(\macro_inst|bridge|ahb_hrdata [8]),
	.Clk(\bus_clk__macro_inst|bridge|apb_pdone_X10004_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10004_Y10001_INV),
	.SyncReset(SyncReset_X10004_Y10001_GND),
	.ShiftData(),
	.SyncLoad(SyncLoad_X10004_Y10001_VCC),
	.LutOut(\macro_inst|bridge|apb_pdone ),
	.Cout(),
	.Q(\macro_inst|bridge|ahb_hrdata [8]));
defparam \macro_inst|bridge|prdata[8]_reg .coord_x = 15;
defparam \macro_inst|bridge|prdata[8]_reg .coord_y = 12;
defparam \macro_inst|bridge|prdata[8]_reg .coord_z = 3;
defparam \macro_inst|bridge|prdata[8]_reg .mask = 16'hAA00;
defparam \macro_inst|bridge|prdata[8]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|prdata[8]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|prdata[8]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|prdata[8]_reg .BypassEn = 1'b1;
defparam \macro_inst|bridge|prdata[8]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|prdata[9]_reg (
	.A(),
	.B(),
	.C(),
	.D(\macro_inst|apb_prdata [9]),
	.Cin(),
	.Qin(\macro_inst|bridge|ahb_hrdata [9]),
	.Clk(\bus_clk__macro_inst|bridge|apb_pdone_X10003_Y10001_SIG_SIG ),
	.AsyncReset(sys_resetn__AsyncReset_X10003_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|prdata[9]_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|bridge|ahb_hrdata [9]));
defparam \macro_inst|bridge|prdata[9]_reg .coord_x = 14;
defparam \macro_inst|bridge|prdata[9]_reg .coord_y = 12;
defparam \macro_inst|bridge|prdata[9]_reg .coord_z = 11;
defparam \macro_inst|bridge|prdata[9]_reg .mask = 16'hFF00;
defparam \macro_inst|bridge|prdata[9]_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|prdata[9]_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|prdata[9]_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|prdata[9]_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|prdata[9]_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|psel_reg (
	.A(\macro_inst|bridge|pvalid ),
	.B(\macro_inst|bridge|apbState[0]_reg_q ),
	.C(vcc),
	.D(\macro_inst|bridge|apbState [1]),
	.Cin(),
	.Qin(\macro_inst|apb_psel ),
	.Clk(bus_clk_X10004_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10004_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|apb_psel_A_Y_B_Y ),
	.Cout(),
	.Q(\macro_inst|apb_psel ));
defparam \macro_inst|bridge|psel_reg .coord_x = 15;
defparam \macro_inst|bridge|psel_reg .coord_y = 12;
defparam \macro_inst|bridge|psel_reg .coord_z = 4;
defparam \macro_inst|bridge|psel_reg .mask = 16'hBAF2;
defparam \macro_inst|bridge|psel_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|psel_reg .FeedbackMux = 1'b1;
defparam \macro_inst|bridge|psel_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|psel_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|psel_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|pvalid_A_1_Y_A_Y_combout (
	.A(vcc),
	.B(\macro_inst|bridge|apbState [1]),
	.C(\macro_inst|bridge|apbState[0]_reg_q ),
	.D(\macro_inst|bridge|pvalid ),
	.Cin(),
	.Qin(),
	.Clk(),
	.AsyncReset(),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|pvalid_A_1_Y_A_Y ),
	.Cout(),
	.Q());
defparam \macro_inst|bridge|pvalid_A_1_Y_A_Y_combout .coord_x = 14;
defparam \macro_inst|bridge|pvalid_A_1_Y_A_Y_combout .coord_y = 12;
defparam \macro_inst|bridge|pvalid_A_1_Y_A_Y_combout .coord_z = 15;
defparam \macro_inst|bridge|pvalid_A_1_Y_A_Y_combout .mask = 16'h00CF;
defparam \macro_inst|bridge|pvalid_A_1_Y_A_Y_combout .modeMux = 1'b0;
defparam \macro_inst|bridge|pvalid_A_1_Y_A_Y_combout .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|pvalid_A_1_Y_A_Y_combout .ShiftMux = 1'b0;
defparam \macro_inst|bridge|pvalid_A_1_Y_A_Y_combout .BypassEn = 1'b0;
defparam \macro_inst|bridge|pvalid_A_1_Y_A_Y_combout .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|pvalid_reg (
	.A(vcc),
	.B(\macro_inst|bridge|pdone ),
	.C(\macro_inst|apb_psel ),
	.D(\macro_inst|bridge|hreadyout_reg_q ),
	.Cin(),
	.Qin(\macro_inst|bridge|pvalid ),
	.Clk(bus_clk_X10004_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10004_Y10001_INV),
	.SyncReset(),
	.ShiftData(),
	.SyncLoad(),
	.LutOut(\macro_inst|bridge|hreadyout_reg_q_A_Y ),
	.Cout(),
	.Q(\macro_inst|bridge|pvalid ));
defparam \macro_inst|bridge|pvalid_reg .coord_x = 15;
defparam \macro_inst|bridge|pvalid_reg .coord_y = 12;
defparam \macro_inst|bridge|pvalid_reg .coord_z = 0;
defparam \macro_inst|bridge|pvalid_reg .mask = 16'h0300;
defparam \macro_inst|bridge|pvalid_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|pvalid_reg .FeedbackMux = 1'b0;
defparam \macro_inst|bridge|pvalid_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|pvalid_reg .BypassEn = 1'b0;
defparam \macro_inst|bridge|pvalid_reg .CarryEnb = 1'b1;

alta_slice \macro_inst|bridge|pwrite_reg (
	.A(),
	.B(),
	.C(\macro_inst|bridge|hwrite ),
	.D(),
	.Cin(),
	.Qin(\macro_inst|apb_pwrite ),
	.Clk(bus_clk_X10005_Y10001_SIG_VCC),
	.AsyncReset(sys_resetn__AsyncReset_X10005_Y10001_INV),
	.SyncReset(SyncReset_X10005_Y10001_GND),
	.ShiftData(),
	.SyncLoad(\macro_inst|bridge|pvalid_A_Y__SyncLoad_X10005_Y10001_SIG ),
	.LutOut(\macro_inst|bridge|pwrite_reg__feeder__LutOut ),
	.Cout(),
	.Q(\macro_inst|apb_pwrite ));
defparam \macro_inst|bridge|pwrite_reg .coord_x = 18;
defparam \macro_inst|bridge|pwrite_reg .coord_y = 12;
defparam \macro_inst|bridge|pwrite_reg .coord_z = 4;
defparam \macro_inst|bridge|pwrite_reg .mask = 16'hF0F0;
defparam \macro_inst|bridge|pwrite_reg .modeMux = 1'b0;
defparam \macro_inst|bridge|pwrite_reg .FeedbackMux = 1'b1;
defparam \macro_inst|bridge|pwrite_reg .ShiftMux = 1'b0;
defparam \macro_inst|bridge|pwrite_reg .BypassEn = 1'b1;
defparam \macro_inst|bridge|pwrite_reg .CarryEnb = 1'b1;

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
	.mem_ahb_hready(\macro_inst|bridge|ahb_hready ),
	.mem_ahb_hreadyout(!\macro_inst|bridge|hreadyout_reg_q ),
	.mem_ahb_htrans({\macro_inst|bridge|ahb_htrans [1], \macro_inst|bridge|ahb_htrans [0]}),
	.mem_ahb_hsize({\macro_inst|bridge|ahb_hsize [2], \macro_inst|bridge|ahb_hsize [1], \macro_inst|bridge|ahb_hsize [0]}),
	.mem_ahb_hburst({\macro_inst|bridge|ahb_hburst [2], \macro_inst|bridge|ahb_hburst [1], \macro_inst|bridge|ahb_hburst [0]}),
	.mem_ahb_hwrite(\macro_inst|bridge|ahb_hwrite ),
	.mem_ahb_haddr({\macro_inst|mem_ahb_haddr [31], \macro_inst|mem_ahb_haddr [30], \macro_inst|mem_ahb_haddr [29], \macro_inst|mem_ahb_haddr [28], \macro_inst|mem_ahb_haddr [27], \macro_inst|mem_ahb_haddr [26], \macro_inst|mem_ahb_haddr [25], \macro_inst|mem_ahb_haddr [24], \macro_inst|mem_ahb_haddr [23], \macro_inst|mem_ahb_haddr [22], \macro_inst|mem_ahb_haddr [21], \macro_inst|mem_ahb_haddr [20], \macro_inst|mem_ahb_haddr [19], \macro_inst|mem_ahb_haddr [18], \macro_inst|mem_ahb_haddr [17], \macro_inst|mem_ahb_haddr [16], \macro_inst|mem_ahb_haddr [15], \macro_inst|mem_ahb_haddr [14], \macro_inst|mem_ahb_haddr [13], \macro_inst|mem_ahb_haddr [12], \macro_inst|mem_ahb_haddr [11], \macro_inst|mem_ahb_haddr [10], \macro_inst|mem_ahb_haddr [9], \macro_inst|mem_ahb_haddr [8], \macro_inst|mem_ahb_haddr [7], \macro_inst|mem_ahb_haddr [6], \macro_inst|mem_ahb_haddr [5], \macro_inst|mem_ahb_haddr [4], \macro_inst|mem_ahb_haddr [3], \macro_inst|mem_ahb_haddr [2], \macro_inst|mem_ahb_haddr [1], \macro_inst|mem_ahb_haddr [0]}),
	.mem_ahb_hwdata({\macro_inst|apb_pwdata [31], \macro_inst|apb_pwdata [30], \macro_inst|apb_pwdata [29], \macro_inst|apb_pwdata [28], \macro_inst|apb_pwdata [27], \macro_inst|apb_pwdata [26], \macro_inst|apb_pwdata [25], \macro_inst|apb_pwdata [24], \macro_inst|apb_pwdata [23], \macro_inst|apb_pwdata [22], \macro_inst|apb_pwdata [21], \macro_inst|apb_pwdata [20], \macro_inst|apb_pwdata [19], \macro_inst|apb_pwdata [18], \macro_inst|apb_pwdata [17], \macro_inst|apb_pwdata [16], \macro_inst|apb_pwdata [15], \macro_inst|apb_pwdata [14], \macro_inst|apb_pwdata [13], \macro_inst|apb_pwdata [12], \macro_inst|apb_pwdata [11], \macro_inst|apb_pwdata [10], \macro_inst|apb_pwdata [9], \macro_inst|apb_pwdata [8], \macro_inst|apb_pwdata [7], \macro_inst|apb_pwdata [6], \macro_inst|apb_pwdata [5], \macro_inst|apb_pwdata [4], \macro_inst|apb_pwdata [3], \macro_inst|apb_pwdata [2], \macro_inst|apb_pwdata [1], \macro_inst|apb_pwdata [0]}),
	.mem_ahb_hresp(gnd),
	.mem_ahb_hrdata({gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, \macro_inst|bridge|ahb_hrdata [11], \macro_inst|bridge|ahb_hrdata [10], \macro_inst|bridge|ahb_hrdata [9], \macro_inst|bridge|ahb_hrdata [8], \macro_inst|bridge|ahb_hrdata [7], \macro_inst|bridge|ahb_hrdata [6], \macro_inst|bridge|ahb_hrdata [5], \macro_inst|bridge|ahb_hrdata [4], \macro_inst|bridge|ahb_hrdata [3], \macro_inst|bridge|ahb_hrdata [2], \macro_inst|bridge|ahb_hrdata [1], \macro_inst|bridge|ahb_hrdata [0]}),
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
	.gpio3_io_in({gnd, gnd, gnd, gnd, gnd, gnd, gnd, gpio3_io_in[0]}),
	.gpio3_io_out_data({gpio3_io_out_data[7], gpio3_io_out_data[6], gpio3_io_out_data[5], gpio3_io_out_data[4], gpio3_io_out_data[3], gpio3_io_out_data[2], gpio3_io_out_data[1], gpio3_io_out_data[0]}),
	.gpio3_io_out_en({gpio3_io_out_en[7], gpio3_io_out_en[6], gpio3_io_out_en[5], gpio3_io_out_en[4], gpio3_io_out_en[3], gpio3_io_out_en[2], gpio3_io_out_en[1], gpio3_io_out_en[0]}),
	.gpio4_io_in({gnd, gnd, gnd, gpio4_io_in[4], gnd, gnd, gnd, gnd}),
	.gpio4_io_out_data({gpio4_io_out_data[7], gpio4_io_out_data[6], gpio4_io_out_data[5], gpio4_io_out_data[4], gpio4_io_out_data[3], gpio4_io_out_data[2], gpio4_io_out_data[1], gpio4_io_out_data[0]}),
	.gpio4_io_out_en({gpio4_io_out_en[7], gpio4_io_out_en[6], gpio4_io_out_en[5], gpio4_io_out_en[4], gpio4_io_out_en[3], gpio4_io_out_en[2], gpio4_io_out_en[1], gpio4_io_out_en[0]}),
	.gpio5_io_in({gnd, gnd, gnd, gnd, gpio5_io_in[3], gpio5_io_in[2], gpio5_io_in[1], gnd}),
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
	.resetn_out(sys_resetn_int),
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

alta_io_gclk \rv32|resetn_out~ALTA_GCLK (
	.inclk(sys_resetn_int),
	.outclk(sys_resetn));
defparam \rv32|resetn_out~ALTA_GCLK .coord_x = 22;
defparam \rv32|resetn_out~ALTA_GCLK .coord_y = 4;
defparam \rv32|resetn_out~ALTA_GCLK .coord_z = 0;

alta_syncctrl syncload_ctrl_X10001_Y10001(
	.Din(),
	.Dout(SyncLoad_X10001_Y10001_VCC));
defparam syncload_ctrl_X10001_Y10001.coord_x = 20;
defparam syncload_ctrl_X10001_Y10001.coord_y = 12;
defparam syncload_ctrl_X10001_Y10001.coord_z = 1;
defparam syncload_ctrl_X10001_Y10001.SyncCtrlMux = 2'b01;

alta_syncctrl syncload_ctrl_X10003_Y10001(
	.Din(\macro_inst|bridge|ahb_htrans_B_1_Y ),
	.Dout(\macro_inst|bridge|ahb_htrans_B_1_Y__SyncLoad_X10003_Y10001_SIG ));
defparam syncload_ctrl_X10003_Y10001.coord_x = 14;
defparam syncload_ctrl_X10003_Y10001.coord_y = 12;
defparam syncload_ctrl_X10003_Y10001.coord_z = 1;
defparam syncload_ctrl_X10003_Y10001.SyncCtrlMux = 2'b10;

alta_syncctrl syncload_ctrl_X10004_Y10001(
	.Din(),
	.Dout(SyncLoad_X10004_Y10001_VCC));
defparam syncload_ctrl_X10004_Y10001.coord_x = 15;
defparam syncload_ctrl_X10004_Y10001.coord_y = 12;
defparam syncload_ctrl_X10004_Y10001.coord_z = 1;
defparam syncload_ctrl_X10004_Y10001.SyncCtrlMux = 2'b01;

alta_syncctrl syncload_ctrl_X10005_Y10001(
	.Din(\macro_inst|bridge|pvalid_A_Y ),
	.Dout(\macro_inst|bridge|pvalid_A_Y__SyncLoad_X10005_Y10001_SIG ));
defparam syncload_ctrl_X10005_Y10001.coord_x = 18;
defparam syncload_ctrl_X10005_Y10001.coord_y = 12;
defparam syncload_ctrl_X10005_Y10001.coord_z = 1;
defparam syncload_ctrl_X10005_Y10001.SyncCtrlMux = 2'b10;

alta_syncctrl syncreset_ctrl_X10001_Y10001(
	.Din(),
	.Dout(SyncReset_X10001_Y10001_GND));
defparam syncreset_ctrl_X10001_Y10001.coord_x = 20;
defparam syncreset_ctrl_X10001_Y10001.coord_y = 12;
defparam syncreset_ctrl_X10001_Y10001.coord_z = 0;
defparam syncreset_ctrl_X10001_Y10001.SyncCtrlMux = 2'b00;

alta_syncctrl syncreset_ctrl_X10003_Y10001(
	.Din(),
	.Dout(SyncReset_X10003_Y10001_GND));
defparam syncreset_ctrl_X10003_Y10001.coord_x = 14;
defparam syncreset_ctrl_X10003_Y10001.coord_y = 12;
defparam syncreset_ctrl_X10003_Y10001.coord_z = 0;
defparam syncreset_ctrl_X10003_Y10001.SyncCtrlMux = 2'b00;

alta_syncctrl syncreset_ctrl_X10004_Y10001(
	.Din(),
	.Dout(SyncReset_X10004_Y10001_GND));
defparam syncreset_ctrl_X10004_Y10001.coord_x = 15;
defparam syncreset_ctrl_X10004_Y10001.coord_y = 12;
defparam syncreset_ctrl_X10004_Y10001.coord_z = 0;
defparam syncreset_ctrl_X10004_Y10001.SyncCtrlMux = 2'b00;

alta_syncctrl syncreset_ctrl_X10005_Y10001(
	.Din(),
	.Dout(SyncReset_X10005_Y10001_GND));
defparam syncreset_ctrl_X10005_Y10001.coord_x = 18;
defparam syncreset_ctrl_X10005_Y10001.coord_y = 12;
defparam syncreset_ctrl_X10005_Y10001.coord_z = 0;
defparam syncreset_ctrl_X10005_Y10001.SyncCtrlMux = 2'b00;

endmodule
