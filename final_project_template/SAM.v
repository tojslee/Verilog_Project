`timescale 1ns/1ps

module SAM();
  reg clk;

  reg [15:0] PC, AC, MAR, MBR, IR;
  reg [15:0] ABUS, RBUS, MBUS;
  reg [15:0] ADDRESS_BUS, DATA_BUS;
  reg RW, REQUEST;
  wire WAIT;

  reg [15:0] ALU_A, ALU_B, ALU_RESULT;
  reg ALU_ADD, ALU_PASS_B;

  wire [21:0] b;
  controller my_controller(clk, WAIT, IR[15], AC[15], IR[14], b);

  wire [15:0] data_bus_t;
  always @ ( RW ) if (RW) DATA_BUS = data_bus_t;
  Memory my_memory(ADDRESS_BUS, REQUEST, RW, WAIT, DATA_BUS, data_bus_t);

  // initial settings
  initial begin
    clk = 0;
    AC = 0;
    IR = 0;
    RW = 1;
    REQUEST = 1;
    ADDRESS_BUS = 0;
  end
  always begin
    clk = ~clk; #1;
  end

  // ALU implementation
  always @ (ALU_ADD or ALU_PASS_B or ALU_A or ALU_B )begin
    if (ALU_ADD) ALU_RESULT = ALU_A + ALU_B;
    else if (ALU_PASS_B) ALU_RESULT = ALU_B;
  end

  always @ ( negedge clk ) begin
    // TODO: refer to lecture note, page 46




  end

  // TODO: refer to lecture note, page 8 and write additional code here







  
endmodule
