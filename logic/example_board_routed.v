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
output	GPIO4_4;
output	GPIO5_0;
output	GPIO5_1;
output	GPIO5_2;
output	GPIO5_3;
input	PIN_HSE;
input	PIN_HSI;
input	PIN_OSC;
output	SPI0_CSN;
output	SPI0_SCK;
output	SPI0_SI_IO0;
input	UART0_UARTRXD;
output	UART0_UARTTXD;

//wire	gnd;
//wire	vcc;
//wire	unknown;
wire	\CAN0_RX0~input_o ;
wire	\GPIO4_4~input_o ;
wire	\GPIO5_0~input_o ;
wire	\GPIO5_1~input_o ;
wire	\GPIO5_2~input_o ;
wire	\GPIO5_3~input_o ;
wire	\PIN_HSE~input_o ;
wire	\PIN_HSI~input_o ;
wire	\PIN_OSC~input_o ;
wire	\SPI0_SI_IO0~input_o ;
wire	\UART0_UARTRXD~input_o ;
tri1	devclrn;
tri1	devoe;
tri1	devpor;
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
wire	\~ALTERA_ASDO_DATA1~~ibuf_o ;
wire	\~ALTERA_ASDO_DATA1~~padout ;
wire	\~ALTERA_DATA0~~ibuf_o ;
wire	\~ALTERA_DATA0~~padout ;
wire	\~ALTERA_FLASH_nCE_nCSO~~ibuf_o ;
wire	\~ALTERA_FLASH_nCE_nCSO~~padout ;

wire vcc;
wire gnd;
assign vcc = 1'b1;
assign gnd = 1'b0;
wire unknown;
assign unknown = 1'bx;

alta_rio \CAN0_RX0~input (
	.padio(CAN0_RX0),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(\CAN0_RX0~input_o ),
	.regout());
defparam \CAN0_RX0~input .coord_x = 19;
defparam \CAN0_RX0~input .coord_y = 13;
defparam \CAN0_RX0~input .coord_z = 3;
defparam \CAN0_RX0~input .IN_ASYNC_MODE = 1'b0;
defparam \CAN0_RX0~input .IN_SYNC_MODE = 1'b0;
defparam \CAN0_RX0~input .IN_POWERUP = 1'b0;
defparam \CAN0_RX0~input .OUT_REG_MODE = 1'b0;
defparam \CAN0_RX0~input .OUT_ASYNC_MODE = 1'b0;
defparam \CAN0_RX0~input .OUT_SYNC_MODE = 1'b0;
defparam \CAN0_RX0~input .OUT_POWERUP = 1'b0;
defparam \CAN0_RX0~input .OE_REG_MODE = 1'b0;
defparam \CAN0_RX0~input .OE_ASYNC_MODE = 1'b0;
defparam \CAN0_RX0~input .OE_SYNC_MODE = 1'b0;
defparam \CAN0_RX0~input .OE_POWERUP = 1'b0;
defparam \CAN0_RX0~input .CFG_TRI_INPUT = 1'b0;
defparam \CAN0_RX0~input .CFG_INPUT_EN = 1'b0;
defparam \CAN0_RX0~input .CFG_PULL_UP = 1'b0;
defparam \CAN0_RX0~input .CFG_SLR = 1'b0;
defparam \CAN0_RX0~input .CFG_OPEN_DRAIN = 1'b0;
defparam \CAN0_RX0~input .CFG_PDRCTRL = 4'b0100;
defparam \CAN0_RX0~input .CFG_KEEP = 2'b00;
defparam \CAN0_RX0~input .CFG_LVDS_OUT_EN = 1'b0;
defparam \CAN0_RX0~input .CFG_LVDS_SEL_CUA = 2'b00;
defparam \CAN0_RX0~input .CFG_LVDS_IREF = 10'b0110000000;
defparam \CAN0_RX0~input .CFG_LVDS_IN_EN = 1'b0;
defparam \CAN0_RX0~input .DPCLK_DELAY = 4'b0000;
defparam \CAN0_RX0~input .OUT_DELAY = 1'b0;
defparam \CAN0_RX0~input .IN_DATA_DELAY = 3'b000;
defparam \CAN0_RX0~input .IN_REG_DELAY = 3'b000;

alta_rio \CAN0_TX0~output (
	.padio(CAN0_TX0),
	.datain(gnd),
	.oe(vcc),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \CAN0_TX0~output .coord_x = 20;
defparam \CAN0_TX0~output .coord_y = 13;
defparam \CAN0_TX0~output .coord_z = 3;
defparam \CAN0_TX0~output .IN_ASYNC_MODE = 1'b0;
defparam \CAN0_TX0~output .IN_SYNC_MODE = 1'b0;
defparam \CAN0_TX0~output .IN_POWERUP = 1'b0;
defparam \CAN0_TX0~output .OUT_REG_MODE = 1'b0;
defparam \CAN0_TX0~output .OUT_ASYNC_MODE = 1'b0;
defparam \CAN0_TX0~output .OUT_SYNC_MODE = 1'b0;
defparam \CAN0_TX0~output .OUT_POWERUP = 1'b0;
defparam \CAN0_TX0~output .OE_REG_MODE = 1'b0;
defparam \CAN0_TX0~output .OE_ASYNC_MODE = 1'b0;
defparam \CAN0_TX0~output .OE_SYNC_MODE = 1'b0;
defparam \CAN0_TX0~output .OE_POWERUP = 1'b0;
defparam \CAN0_TX0~output .CFG_TRI_INPUT = 1'b0;
defparam \CAN0_TX0~output .CFG_INPUT_EN = 1'b0;
defparam \CAN0_TX0~output .CFG_PULL_UP = 1'b0;
defparam \CAN0_TX0~output .CFG_SLR = 1'b0;
defparam \CAN0_TX0~output .CFG_OPEN_DRAIN = 1'b0;
defparam \CAN0_TX0~output .CFG_PDRCTRL = 4'b0100;
defparam \CAN0_TX0~output .CFG_KEEP = 2'b00;
defparam \CAN0_TX0~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \CAN0_TX0~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \CAN0_TX0~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \CAN0_TX0~output .CFG_LVDS_IN_EN = 1'b0;
defparam \CAN0_TX0~output .DPCLK_DELAY = 4'b0000;
defparam \CAN0_TX0~output .OUT_DELAY = 1'b0;
defparam \CAN0_TX0~output .IN_DATA_DELAY = 3'b000;
defparam \CAN0_TX0~output .IN_REG_DELAY = 3'b000;

alta_rio \GPIO4_4~output (
	.padio(GPIO4_4),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(\GPIO4_4~input_o ),
	.regout());
defparam \GPIO4_4~output .coord_x = 18;
defparam \GPIO4_4~output .coord_y = 0;
defparam \GPIO4_4~output .coord_z = 1;
defparam \GPIO4_4~output .IN_ASYNC_MODE = 1'b0;
defparam \GPIO4_4~output .IN_SYNC_MODE = 1'b0;
defparam \GPIO4_4~output .IN_POWERUP = 1'b0;
defparam \GPIO4_4~output .OUT_REG_MODE = 1'b0;
defparam \GPIO4_4~output .OUT_ASYNC_MODE = 1'b0;
defparam \GPIO4_4~output .OUT_SYNC_MODE = 1'b0;
defparam \GPIO4_4~output .OUT_POWERUP = 1'b0;
defparam \GPIO4_4~output .OE_REG_MODE = 1'b0;
defparam \GPIO4_4~output .OE_ASYNC_MODE = 1'b0;
defparam \GPIO4_4~output .OE_SYNC_MODE = 1'b0;
defparam \GPIO4_4~output .OE_POWERUP = 1'b0;
defparam \GPIO4_4~output .CFG_TRI_INPUT = 1'b0;
defparam \GPIO4_4~output .CFG_INPUT_EN = 1'b0;
defparam \GPIO4_4~output .CFG_PULL_UP = 1'b0;
defparam \GPIO4_4~output .CFG_SLR = 1'b0;
defparam \GPIO4_4~output .CFG_OPEN_DRAIN = 1'b0;
defparam \GPIO4_4~output .CFG_PDRCTRL = 4'b0100;
defparam \GPIO4_4~output .CFG_KEEP = 2'b00;
defparam \GPIO4_4~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \GPIO4_4~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \GPIO4_4~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \GPIO4_4~output .CFG_LVDS_IN_EN = 1'b0;
defparam \GPIO4_4~output .DPCLK_DELAY = 4'b0000;
defparam \GPIO4_4~output .OUT_DELAY = 1'b0;
defparam \GPIO4_4~output .IN_DATA_DELAY = 3'b000;
defparam \GPIO4_4~output .IN_REG_DELAY = 3'b000;

alta_rio \GPIO5_0~output (
	.padio(GPIO5_0),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(\GPIO5_0~input_o ),
	.regout());
defparam \GPIO5_0~output .coord_x = 19;
defparam \GPIO5_0~output .coord_y = 0;
defparam \GPIO5_0~output .coord_z = 1;
defparam \GPIO5_0~output .IN_ASYNC_MODE = 1'b0;
defparam \GPIO5_0~output .IN_SYNC_MODE = 1'b0;
defparam \GPIO5_0~output .IN_POWERUP = 1'b0;
defparam \GPIO5_0~output .OUT_REG_MODE = 1'b0;
defparam \GPIO5_0~output .OUT_ASYNC_MODE = 1'b0;
defparam \GPIO5_0~output .OUT_SYNC_MODE = 1'b0;
defparam \GPIO5_0~output .OUT_POWERUP = 1'b0;
defparam \GPIO5_0~output .OE_REG_MODE = 1'b0;
defparam \GPIO5_0~output .OE_ASYNC_MODE = 1'b0;
defparam \GPIO5_0~output .OE_SYNC_MODE = 1'b0;
defparam \GPIO5_0~output .OE_POWERUP = 1'b0;
defparam \GPIO5_0~output .CFG_TRI_INPUT = 1'b0;
defparam \GPIO5_0~output .CFG_INPUT_EN = 1'b0;
defparam \GPIO5_0~output .CFG_PULL_UP = 1'b0;
defparam \GPIO5_0~output .CFG_SLR = 1'b0;
defparam \GPIO5_0~output .CFG_OPEN_DRAIN = 1'b0;
defparam \GPIO5_0~output .CFG_PDRCTRL = 4'b0100;
defparam \GPIO5_0~output .CFG_KEEP = 2'b00;
defparam \GPIO5_0~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \GPIO5_0~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \GPIO5_0~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \GPIO5_0~output .CFG_LVDS_IN_EN = 1'b0;
defparam \GPIO5_0~output .DPCLK_DELAY = 4'b0000;
defparam \GPIO5_0~output .OUT_DELAY = 1'b0;
defparam \GPIO5_0~output .IN_DATA_DELAY = 3'b000;
defparam \GPIO5_0~output .IN_REG_DELAY = 3'b000;

alta_rio \GPIO5_1~output (
	.padio(GPIO5_1),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(\GPIO5_1~input_o ),
	.regout());
defparam \GPIO5_1~output .coord_x = 0;
defparam \GPIO5_1~output .coord_y = 2;
defparam \GPIO5_1~output .coord_z = 5;
defparam \GPIO5_1~output .IN_ASYNC_MODE = 1'b0;
defparam \GPIO5_1~output .IN_SYNC_MODE = 1'b0;
defparam \GPIO5_1~output .IN_POWERUP = 1'b0;
defparam \GPIO5_1~output .OUT_REG_MODE = 1'b0;
defparam \GPIO5_1~output .OUT_ASYNC_MODE = 1'b0;
defparam \GPIO5_1~output .OUT_SYNC_MODE = 1'b0;
defparam \GPIO5_1~output .OUT_POWERUP = 1'b0;
defparam \GPIO5_1~output .OE_REG_MODE = 1'b0;
defparam \GPIO5_1~output .OE_ASYNC_MODE = 1'b0;
defparam \GPIO5_1~output .OE_SYNC_MODE = 1'b0;
defparam \GPIO5_1~output .OE_POWERUP = 1'b0;
defparam \GPIO5_1~output .CFG_TRI_INPUT = 1'b0;
defparam \GPIO5_1~output .CFG_INPUT_EN = 1'b0;
defparam \GPIO5_1~output .CFG_PULL_UP = 1'b0;
defparam \GPIO5_1~output .CFG_SLR = 1'b0;
defparam \GPIO5_1~output .CFG_OPEN_DRAIN = 1'b0;
defparam \GPIO5_1~output .CFG_PDRCTRL = 4'b0100;
defparam \GPIO5_1~output .CFG_KEEP = 2'b00;
defparam \GPIO5_1~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \GPIO5_1~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \GPIO5_1~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \GPIO5_1~output .CFG_LVDS_IN_EN = 1'b0;
defparam \GPIO5_1~output .DPCLK_DELAY = 4'b0000;
defparam \GPIO5_1~output .OUT_DELAY = 1'b0;
defparam \GPIO5_1~output .IN_DATA_DELAY = 3'b000;
defparam \GPIO5_1~output .IN_REG_DELAY = 3'b000;

alta_rio \GPIO5_2~output (
	.padio(GPIO5_2),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(\GPIO5_2~input_o ),
	.regout());
defparam \GPIO5_2~output .coord_x = 0;
defparam \GPIO5_2~output .coord_y = 1;
defparam \GPIO5_2~output .coord_z = 0;
defparam \GPIO5_2~output .IN_ASYNC_MODE = 1'b0;
defparam \GPIO5_2~output .IN_SYNC_MODE = 1'b0;
defparam \GPIO5_2~output .IN_POWERUP = 1'b0;
defparam \GPIO5_2~output .OUT_REG_MODE = 1'b0;
defparam \GPIO5_2~output .OUT_ASYNC_MODE = 1'b0;
defparam \GPIO5_2~output .OUT_SYNC_MODE = 1'b0;
defparam \GPIO5_2~output .OUT_POWERUP = 1'b0;
defparam \GPIO5_2~output .OE_REG_MODE = 1'b0;
defparam \GPIO5_2~output .OE_ASYNC_MODE = 1'b0;
defparam \GPIO5_2~output .OE_SYNC_MODE = 1'b0;
defparam \GPIO5_2~output .OE_POWERUP = 1'b0;
defparam \GPIO5_2~output .CFG_TRI_INPUT = 1'b0;
defparam \GPIO5_2~output .CFG_INPUT_EN = 1'b0;
defparam \GPIO5_2~output .CFG_PULL_UP = 1'b0;
defparam \GPIO5_2~output .CFG_SLR = 1'b0;
defparam \GPIO5_2~output .CFG_OPEN_DRAIN = 1'b0;
defparam \GPIO5_2~output .CFG_PDRCTRL = 4'b0100;
defparam \GPIO5_2~output .CFG_KEEP = 2'b00;
defparam \GPIO5_2~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \GPIO5_2~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \GPIO5_2~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \GPIO5_2~output .CFG_LVDS_IN_EN = 1'b0;
defparam \GPIO5_2~output .DPCLK_DELAY = 4'b0000;
defparam \GPIO5_2~output .OUT_DELAY = 1'b0;
defparam \GPIO5_2~output .IN_DATA_DELAY = 3'b000;
defparam \GPIO5_2~output .IN_REG_DELAY = 3'b000;

alta_rio \GPIO5_3~output (
	.padio(GPIO5_3),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(\GPIO5_3~input_o ),
	.regout());
defparam \GPIO5_3~output .coord_x = 0;
defparam \GPIO5_3~output .coord_y = 1;
defparam \GPIO5_3~output .coord_z = 3;
defparam \GPIO5_3~output .IN_ASYNC_MODE = 1'b0;
defparam \GPIO5_3~output .IN_SYNC_MODE = 1'b0;
defparam \GPIO5_3~output .IN_POWERUP = 1'b0;
defparam \GPIO5_3~output .OUT_REG_MODE = 1'b0;
defparam \GPIO5_3~output .OUT_ASYNC_MODE = 1'b0;
defparam \GPIO5_3~output .OUT_SYNC_MODE = 1'b0;
defparam \GPIO5_3~output .OUT_POWERUP = 1'b0;
defparam \GPIO5_3~output .OE_REG_MODE = 1'b0;
defparam \GPIO5_3~output .OE_ASYNC_MODE = 1'b0;
defparam \GPIO5_3~output .OE_SYNC_MODE = 1'b0;
defparam \GPIO5_3~output .OE_POWERUP = 1'b0;
defparam \GPIO5_3~output .CFG_TRI_INPUT = 1'b0;
defparam \GPIO5_3~output .CFG_INPUT_EN = 1'b0;
defparam \GPIO5_3~output .CFG_PULL_UP = 1'b0;
defparam \GPIO5_3~output .CFG_SLR = 1'b0;
defparam \GPIO5_3~output .CFG_OPEN_DRAIN = 1'b0;
defparam \GPIO5_3~output .CFG_PDRCTRL = 4'b0100;
defparam \GPIO5_3~output .CFG_KEEP = 2'b00;
defparam \GPIO5_3~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \GPIO5_3~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \GPIO5_3~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \GPIO5_3~output .CFG_LVDS_IN_EN = 1'b0;
defparam \GPIO5_3~output .DPCLK_DELAY = 4'b0000;
defparam \GPIO5_3~output .OUT_DELAY = 1'b0;
defparam \GPIO5_3~output .IN_DATA_DELAY = 3'b000;
defparam \GPIO5_3~output .IN_REG_DELAY = 3'b000;

alta_rio \PIN_HSE~input (
	.padio(PIN_HSE),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(\PIN_HSE~input_o ),
	.regout());
defparam \PIN_HSE~input .coord_x = 22;
defparam \PIN_HSE~input .coord_y = 4;
defparam \PIN_HSE~input .coord_z = 1;
defparam \PIN_HSE~input .IN_ASYNC_MODE = 1'b0;
defparam \PIN_HSE~input .IN_SYNC_MODE = 1'b0;
defparam \PIN_HSE~input .IN_POWERUP = 1'b0;
defparam \PIN_HSE~input .OUT_REG_MODE = 1'b0;
defparam \PIN_HSE~input .OUT_ASYNC_MODE = 1'b0;
defparam \PIN_HSE~input .OUT_SYNC_MODE = 1'b0;
defparam \PIN_HSE~input .OUT_POWERUP = 1'b0;
defparam \PIN_HSE~input .OE_REG_MODE = 1'b0;
defparam \PIN_HSE~input .OE_ASYNC_MODE = 1'b0;
defparam \PIN_HSE~input .OE_SYNC_MODE = 1'b0;
defparam \PIN_HSE~input .OE_POWERUP = 1'b0;
defparam \PIN_HSE~input .CFG_TRI_INPUT = 1'b0;
defparam \PIN_HSE~input .CFG_PULL_UP = 1'b0;
defparam \PIN_HSE~input .CFG_SLR = 1'b0;
defparam \PIN_HSE~input .CFG_OPEN_DRAIN = 1'b0;
defparam \PIN_HSE~input .CFG_PDRCTRL = 4'b0010;
defparam \PIN_HSE~input .CFG_KEEP = 2'b00;
defparam \PIN_HSE~input .CFG_LVDS_OUT_EN = 1'b0;
defparam \PIN_HSE~input .CFG_LVDS_SEL_CUA = 2'b00;
defparam \PIN_HSE~input .CFG_LVDS_IREF = 10'b0110000000;
defparam \PIN_HSE~input .CFG_LVDS_IN_EN = 1'b0;
defparam \PIN_HSE~input .DPCLK_DELAY = 4'b0000;
defparam \PIN_HSE~input .OUT_DELAY = 1'b0;
defparam \PIN_HSE~input .IN_DATA_DELAY = 3'b000;
defparam \PIN_HSE~input .IN_REG_DELAY = 3'b000;

alta_rio \PIN_HSI~input (
	.padio(PIN_HSI),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(\PIN_HSI~input_o ),
	.regout());
defparam \PIN_HSI~input .coord_x = 22;
defparam \PIN_HSI~input .coord_y = 4;
defparam \PIN_HSI~input .coord_z = 0;
defparam \PIN_HSI~input .IN_ASYNC_MODE = 1'b0;
defparam \PIN_HSI~input .IN_SYNC_MODE = 1'b0;
defparam \PIN_HSI~input .IN_POWERUP = 1'b0;
defparam \PIN_HSI~input .OUT_REG_MODE = 1'b0;
defparam \PIN_HSI~input .OUT_ASYNC_MODE = 1'b0;
defparam \PIN_HSI~input .OUT_SYNC_MODE = 1'b0;
defparam \PIN_HSI~input .OUT_POWERUP = 1'b0;
defparam \PIN_HSI~input .OE_REG_MODE = 1'b0;
defparam \PIN_HSI~input .OE_ASYNC_MODE = 1'b0;
defparam \PIN_HSI~input .OE_SYNC_MODE = 1'b0;
defparam \PIN_HSI~input .OE_POWERUP = 1'b0;
defparam \PIN_HSI~input .CFG_TRI_INPUT = 1'b0;
defparam \PIN_HSI~input .CFG_PULL_UP = 1'b0;
defparam \PIN_HSI~input .CFG_SLR = 1'b0;
defparam \PIN_HSI~input .CFG_OPEN_DRAIN = 1'b0;
defparam \PIN_HSI~input .CFG_PDRCTRL = 4'b0010;
defparam \PIN_HSI~input .CFG_KEEP = 2'b00;
defparam \PIN_HSI~input .CFG_LVDS_OUT_EN = 1'b0;
defparam \PIN_HSI~input .CFG_LVDS_SEL_CUA = 2'b00;
defparam \PIN_HSI~input .CFG_LVDS_IREF = 10'b0110000000;
defparam \PIN_HSI~input .CFG_LVDS_IN_EN = 1'b0;
defparam \PIN_HSI~input .DPCLK_DELAY = 4'b0000;
defparam \PIN_HSI~input .OUT_DELAY = 1'b0;
defparam \PIN_HSI~input .IN_DATA_DELAY = 3'b000;
defparam \PIN_HSI~input .IN_REG_DELAY = 3'b000;

alta_rio \PIN_OSC~input (
	.padio(PIN_OSC),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(\PIN_OSC~input_o ),
	.regout());
defparam \PIN_OSC~input .coord_x = 22;
defparam \PIN_OSC~input .coord_y = 4;
defparam \PIN_OSC~input .coord_z = 2;
defparam \PIN_OSC~input .IN_ASYNC_MODE = 1'b0;
defparam \PIN_OSC~input .IN_SYNC_MODE = 1'b0;
defparam \PIN_OSC~input .IN_POWERUP = 1'b0;
defparam \PIN_OSC~input .OUT_REG_MODE = 1'b0;
defparam \PIN_OSC~input .OUT_ASYNC_MODE = 1'b0;
defparam \PIN_OSC~input .OUT_SYNC_MODE = 1'b0;
defparam \PIN_OSC~input .OUT_POWERUP = 1'b0;
defparam \PIN_OSC~input .OE_REG_MODE = 1'b0;
defparam \PIN_OSC~input .OE_ASYNC_MODE = 1'b0;
defparam \PIN_OSC~input .OE_SYNC_MODE = 1'b0;
defparam \PIN_OSC~input .OE_POWERUP = 1'b0;
defparam \PIN_OSC~input .CFG_TRI_INPUT = 1'b0;
defparam \PIN_OSC~input .CFG_PULL_UP = 1'b0;
defparam \PIN_OSC~input .CFG_SLR = 1'b0;
defparam \PIN_OSC~input .CFG_OPEN_DRAIN = 1'b0;
defparam \PIN_OSC~input .CFG_PDRCTRL = 4'b0010;
defparam \PIN_OSC~input .CFG_KEEP = 2'b00;
defparam \PIN_OSC~input .CFG_LVDS_OUT_EN = 1'b0;
defparam \PIN_OSC~input .CFG_LVDS_SEL_CUA = 2'b00;
defparam \PIN_OSC~input .CFG_LVDS_IREF = 10'b0110000000;
defparam \PIN_OSC~input .CFG_LVDS_IN_EN = 1'b0;
defparam \PIN_OSC~input .DPCLK_DELAY = 4'b0000;
defparam \PIN_OSC~input .OUT_DELAY = 1'b0;
defparam \PIN_OSC~input .IN_DATA_DELAY = 3'b000;
defparam \PIN_OSC~input .IN_REG_DELAY = 3'b000;

alta_rio \SPI0_CSN~output (
	.padio(SPI0_CSN),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \SPI0_CSN~output .coord_x = 0;
defparam \SPI0_CSN~output .coord_y = 1;
defparam \SPI0_CSN~output .coord_z = 2;
defparam \SPI0_CSN~output .IN_ASYNC_MODE = 1'b0;
defparam \SPI0_CSN~output .IN_SYNC_MODE = 1'b0;
defparam \SPI0_CSN~output .IN_POWERUP = 1'b0;
defparam \SPI0_CSN~output .OUT_REG_MODE = 1'b0;
defparam \SPI0_CSN~output .OUT_ASYNC_MODE = 1'b0;
defparam \SPI0_CSN~output .OUT_SYNC_MODE = 1'b0;
defparam \SPI0_CSN~output .OUT_POWERUP = 1'b0;
defparam \SPI0_CSN~output .OE_REG_MODE = 1'b0;
defparam \SPI0_CSN~output .OE_ASYNC_MODE = 1'b0;
defparam \SPI0_CSN~output .OE_SYNC_MODE = 1'b0;
defparam \SPI0_CSN~output .OE_POWERUP = 1'b0;
defparam \SPI0_CSN~output .CFG_TRI_INPUT = 1'b0;
defparam \SPI0_CSN~output .CFG_INPUT_EN = 1'b0;
defparam \SPI0_CSN~output .CFG_PULL_UP = 1'b0;
defparam \SPI0_CSN~output .CFG_SLR = 1'b0;
defparam \SPI0_CSN~output .CFG_OPEN_DRAIN = 1'b0;
defparam \SPI0_CSN~output .CFG_PDRCTRL = 4'b0100;
defparam \SPI0_CSN~output .CFG_KEEP = 2'b00;
defparam \SPI0_CSN~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \SPI0_CSN~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \SPI0_CSN~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \SPI0_CSN~output .CFG_LVDS_IN_EN = 1'b0;
defparam \SPI0_CSN~output .DPCLK_DELAY = 4'b0000;
defparam \SPI0_CSN~output .OUT_DELAY = 1'b0;
defparam \SPI0_CSN~output .IN_DATA_DELAY = 3'b000;
defparam \SPI0_CSN~output .IN_REG_DELAY = 3'b000;

alta_rio \SPI0_SCK~output (
	.padio(SPI0_SCK),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \SPI0_SCK~output .coord_x = 0;
defparam \SPI0_SCK~output .coord_y = 4;
defparam \SPI0_SCK~output .coord_z = 3;
defparam \SPI0_SCK~output .IN_ASYNC_MODE = 1'b0;
defparam \SPI0_SCK~output .IN_SYNC_MODE = 1'b0;
defparam \SPI0_SCK~output .IN_POWERUP = 1'b0;
defparam \SPI0_SCK~output .OUT_REG_MODE = 1'b0;
defparam \SPI0_SCK~output .OUT_ASYNC_MODE = 1'b0;
defparam \SPI0_SCK~output .OUT_SYNC_MODE = 1'b0;
defparam \SPI0_SCK~output .OUT_POWERUP = 1'b0;
defparam \SPI0_SCK~output .OE_REG_MODE = 1'b0;
defparam \SPI0_SCK~output .OE_ASYNC_MODE = 1'b0;
defparam \SPI0_SCK~output .OE_SYNC_MODE = 1'b0;
defparam \SPI0_SCK~output .OE_POWERUP = 1'b0;
defparam \SPI0_SCK~output .CFG_TRI_INPUT = 1'b0;
defparam \SPI0_SCK~output .CFG_INPUT_EN = 1'b0;
defparam \SPI0_SCK~output .CFG_PULL_UP = 1'b0;
defparam \SPI0_SCK~output .CFG_SLR = 1'b0;
defparam \SPI0_SCK~output .CFG_OPEN_DRAIN = 1'b0;
defparam \SPI0_SCK~output .CFG_PDRCTRL = 4'b0100;
defparam \SPI0_SCK~output .CFG_KEEP = 2'b00;
defparam \SPI0_SCK~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \SPI0_SCK~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \SPI0_SCK~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \SPI0_SCK~output .CFG_LVDS_IN_EN = 1'b0;
defparam \SPI0_SCK~output .DPCLK_DELAY = 4'b0000;
defparam \SPI0_SCK~output .OUT_DELAY = 1'b0;
defparam \SPI0_SCK~output .IN_DATA_DELAY = 3'b000;
defparam \SPI0_SCK~output .IN_REG_DELAY = 3'b000;

alta_rio \SPI0_SI_IO0~output (
	.padio(SPI0_SI_IO0),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(\SPI0_SI_IO0~input_o ),
	.regout());
defparam \SPI0_SI_IO0~output .coord_x = 0;
defparam \SPI0_SI_IO0~output .coord_y = 2;
defparam \SPI0_SI_IO0~output .coord_z = 4;
defparam \SPI0_SI_IO0~output .IN_ASYNC_MODE = 1'b0;
defparam \SPI0_SI_IO0~output .IN_SYNC_MODE = 1'b0;
defparam \SPI0_SI_IO0~output .IN_POWERUP = 1'b0;
defparam \SPI0_SI_IO0~output .OUT_REG_MODE = 1'b0;
defparam \SPI0_SI_IO0~output .OUT_ASYNC_MODE = 1'b0;
defparam \SPI0_SI_IO0~output .OUT_SYNC_MODE = 1'b0;
defparam \SPI0_SI_IO0~output .OUT_POWERUP = 1'b0;
defparam \SPI0_SI_IO0~output .OE_REG_MODE = 1'b0;
defparam \SPI0_SI_IO0~output .OE_ASYNC_MODE = 1'b0;
defparam \SPI0_SI_IO0~output .OE_SYNC_MODE = 1'b0;
defparam \SPI0_SI_IO0~output .OE_POWERUP = 1'b0;
defparam \SPI0_SI_IO0~output .CFG_TRI_INPUT = 1'b0;
defparam \SPI0_SI_IO0~output .CFG_INPUT_EN = 1'b0;
defparam \SPI0_SI_IO0~output .CFG_PULL_UP = 1'b0;
defparam \SPI0_SI_IO0~output .CFG_SLR = 1'b0;
defparam \SPI0_SI_IO0~output .CFG_OPEN_DRAIN = 1'b0;
defparam \SPI0_SI_IO0~output .CFG_PDRCTRL = 4'b0100;
defparam \SPI0_SI_IO0~output .CFG_KEEP = 2'b00;
defparam \SPI0_SI_IO0~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \SPI0_SI_IO0~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \SPI0_SI_IO0~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \SPI0_SI_IO0~output .CFG_LVDS_IN_EN = 1'b0;
defparam \SPI0_SI_IO0~output .DPCLK_DELAY = 4'b0000;
defparam \SPI0_SI_IO0~output .OUT_DELAY = 1'b0;
defparam \SPI0_SI_IO0~output .IN_DATA_DELAY = 3'b000;
defparam \SPI0_SI_IO0~output .IN_REG_DELAY = 3'b000;

alta_rio \UART0_UARTRXD~input (
	.padio(UART0_UARTRXD),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(\UART0_UARTRXD~input_o ),
	.regout());
defparam \UART0_UARTRXD~input .coord_x = 14;
defparam \UART0_UARTRXD~input .coord_y = 13;
defparam \UART0_UARTRXD~input .coord_z = 2;
defparam \UART0_UARTRXD~input .IN_ASYNC_MODE = 1'b0;
defparam \UART0_UARTRXD~input .IN_SYNC_MODE = 1'b0;
defparam \UART0_UARTRXD~input .IN_POWERUP = 1'b0;
defparam \UART0_UARTRXD~input .OUT_REG_MODE = 1'b0;
defparam \UART0_UARTRXD~input .OUT_ASYNC_MODE = 1'b0;
defparam \UART0_UARTRXD~input .OUT_SYNC_MODE = 1'b0;
defparam \UART0_UARTRXD~input .OUT_POWERUP = 1'b0;
defparam \UART0_UARTRXD~input .OE_REG_MODE = 1'b0;
defparam \UART0_UARTRXD~input .OE_ASYNC_MODE = 1'b0;
defparam \UART0_UARTRXD~input .OE_SYNC_MODE = 1'b0;
defparam \UART0_UARTRXD~input .OE_POWERUP = 1'b0;
defparam \UART0_UARTRXD~input .CFG_TRI_INPUT = 1'b0;
defparam \UART0_UARTRXD~input .CFG_INPUT_EN = 1'b0;
defparam \UART0_UARTRXD~input .CFG_PULL_UP = 1'b0;
defparam \UART0_UARTRXD~input .CFG_SLR = 1'b0;
defparam \UART0_UARTRXD~input .CFG_OPEN_DRAIN = 1'b0;
defparam \UART0_UARTRXD~input .CFG_PDRCTRL = 4'b0100;
defparam \UART0_UARTRXD~input .CFG_KEEP = 2'b00;
defparam \UART0_UARTRXD~input .CFG_LVDS_OUT_EN = 1'b0;
defparam \UART0_UARTRXD~input .CFG_LVDS_SEL_CUA = 2'b00;
defparam \UART0_UARTRXD~input .CFG_LVDS_IREF = 10'b0110000000;
defparam \UART0_UARTRXD~input .CFG_LVDS_IN_EN = 1'b0;
defparam \UART0_UARTRXD~input .DPCLK_DELAY = 4'b0000;
defparam \UART0_UARTRXD~input .OUT_DELAY = 1'b0;
defparam \UART0_UARTRXD~input .IN_DATA_DELAY = 3'b000;
defparam \UART0_UARTRXD~input .IN_REG_DELAY = 3'b000;

alta_rio \UART0_UARTTXD~output (
	.padio(UART0_UARTTXD),
	.datain(gnd),
	.oe(gnd),
	.outclk(gnd),
	.outclkena(vcc),
	.inclk(gnd),
	.inclkena(vcc),
	.areset(gnd),
	.sreset(gnd),
	.combout(),
	.regout());
defparam \UART0_UARTTXD~output .coord_x = 17;
defparam \UART0_UARTTXD~output .coord_y = 13;
defparam \UART0_UARTTXD~output .coord_z = 2;
defparam \UART0_UARTTXD~output .IN_ASYNC_MODE = 1'b0;
defparam \UART0_UARTTXD~output .IN_SYNC_MODE = 1'b0;
defparam \UART0_UARTTXD~output .IN_POWERUP = 1'b0;
defparam \UART0_UARTTXD~output .OUT_REG_MODE = 1'b0;
defparam \UART0_UARTTXD~output .OUT_ASYNC_MODE = 1'b0;
defparam \UART0_UARTTXD~output .OUT_SYNC_MODE = 1'b0;
defparam \UART0_UARTTXD~output .OUT_POWERUP = 1'b0;
defparam \UART0_UARTTXD~output .OE_REG_MODE = 1'b0;
defparam \UART0_UARTTXD~output .OE_ASYNC_MODE = 1'b0;
defparam \UART0_UARTTXD~output .OE_SYNC_MODE = 1'b0;
defparam \UART0_UARTTXD~output .OE_POWERUP = 1'b0;
defparam \UART0_UARTTXD~output .CFG_TRI_INPUT = 1'b0;
defparam \UART0_UARTTXD~output .CFG_INPUT_EN = 1'b0;
defparam \UART0_UARTTXD~output .CFG_PULL_UP = 1'b0;
defparam \UART0_UARTTXD~output .CFG_SLR = 1'b0;
defparam \UART0_UARTTXD~output .CFG_OPEN_DRAIN = 1'b0;
defparam \UART0_UARTTXD~output .CFG_PDRCTRL = 4'b0100;
defparam \UART0_UARTTXD~output .CFG_KEEP = 2'b00;
defparam \UART0_UARTTXD~output .CFG_LVDS_OUT_EN = 1'b0;
defparam \UART0_UARTTXD~output .CFG_LVDS_SEL_CUA = 2'b00;
defparam \UART0_UARTTXD~output .CFG_LVDS_IREF = 10'b0110000000;
defparam \UART0_UARTTXD~output .CFG_LVDS_IN_EN = 1'b0;
defparam \UART0_UARTTXD~output .DPCLK_DELAY = 4'b0000;
defparam \UART0_UARTTXD~output .OUT_DELAY = 1'b0;
defparam \UART0_UARTTXD~output .IN_DATA_DELAY = 3'b000;
defparam \UART0_UARTTXD~output .IN_REG_DELAY = 3'b000;

endmodule
