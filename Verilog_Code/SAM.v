
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
    
    if (b[21]) begin
      ABUS = PC;
    end
    
    if (b[5]) begin
      PC = PC + 2'b10;
    end
    
    if (b[10]) begin
      MAR = ABUS;
    end
    
    if (b[9]) begin
      MBR = data_bus_t;
    end
    
    if (b[7]) begin
      MBUS = MBR;
    end
    
    if (b[20]) begin
      ABUS = IR;
    end
    
    if (b[19]) begin
      ABUS = MBR;
    end
    
    if (b[17]) begin
      ALU_A = AC;
    end
    
    if (b[16]) begin
      ALU_B = MBUS;
    end
    
    if (b[15]) begin
      ALU_ADD = 1;
    end
    else begin
      ALU_ADD = 0;
    end
    
    if (b[14]) begin
      ALU_PASS_B = 1;
    end
    else begin
      ALU_PASS_B = 0;
    end
    
    if (b[13]) begin
      ADDRESS_BUS = MAR;
    end
    
    if (b[12]) begin
      DATA_BUS = MBR;
    end
    
    if (b[11]) begin
      IR = ABUS;
    end
    
    if (b[3]) begin
      RW = 1;
    end
    else begin
      RW = 0;
    end
    
    if (b[2]) begin
      REQUEST = 1;
    end
    else begin
      REQUEST = 0;
    end
    
    if (b[8]) begin
      MBR = RBUS;
    end
    
    if (b[6]) begin
      PC = 0;
    end
    
    if (b[4]) begin
      PC = ABUS;
    end
    
    if (b[1]) begin
      RBUS = AC;
    end
    
    // TODO: refer to lecture note, page 46
/* Example 1. clk-synchrinized implementation
    if		(b[21]) ABUS = PC;
    if		(b[20]) ABUS = IR;
    if		(b[19]) ABUS = MBR;
*/
  end
  
  always @ (negedge clk or ALU_RESULT) begin
    if (b[0]) begin
      RBUS = ALU_RESULT;
    end
  end
  
  always @ (negedge clk or RBUS) begin
    if (b[18]) begin
      AC = RBUS;
    end
  end

  // TODO: refer to lecture note, page 8 and write additional code here
  
endmodule

