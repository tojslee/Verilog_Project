
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
    if (b[21]) begin
      assign ABUS = PC;
    end
    
    if (b[20]) begin
      assign ABUS = PC;
    end
    
    if (b[19]) begin
      assign ABUS = IR;
    end
    
    if (b[18]) begin
      assign ABUS = MAR;
    end
    
    if (b[17]) begin
      assign AC = RBUS;
    end
    
    if (b[16]) begin
      assign ALU_A = AC;
    end
    
    if (b[15]) begin
      assign ALU_B = MBUS;
    end
    
    if (b[14]) begin
      assign ALU_ADD = 1;
    end
    else begin
      assign ALU_ADD = 0;
    end
    
    if (b[13]) begin
      assign ALU_PASS_B = 1;
    end
    else begin
      assign ALU_PASS_B = 0;
    end
    
    if (b[12]) begin
      assign ADDRESS_BUS = MAR;
    end
    
    if (b[11]) begin
      assign DATA_BUS = MBR;
    end
    
    if (b[10]) begin
      assign IR = ABUS;
    end
    
    if (b[9]) begin
      assign MAR = ABUS;
    end
    
    if (b[8]) begin
      assign MBR = DATA_BUS;
    end
    
    if (b[7]) begin
      assign MBR = RBUS;
    end
    
    if (b[6]) begin
      assign PC = 0;
    end
    
    if (b[5]) begin
      assign PC = PC + 2'b10;
    end
    
    if (b[4]) begin
      assign PC = ABUS;
    end
    
    if (b[3]) begin
      assign RW = 1;
    end
    else begin
      assign RW = 0;
    end
    
    if (b[2]) begin
      assign REQUEST = 1;
    end
    else begin
      assign REQUEST = 0;
    end
    
    if (b[1]) begin
      assign RBUS = AC;
    end
    
    if (b[0]) begin
      assign RBUS = ALU_RESULT;
    end
  end
  // TODO: refer to lecture note, page 8 and write additional code here
  
  
  /*
  always @ ( negedge clk ) begin
     if (b[21]) begin
      assign ABUS = PC;
    end
    
    if (b[20]) begin
      assign ABUS = IR;
    end
    
    if (b[19]) begin
      assign ABUS = MBR;
    end
    
    if (b[18]) begin
      assign AC = RBUS;
    end
    
    if (b[17]) begin
      assign ALU_A = AC;
    end
    
    if (b[16]) begin
      assign ALU_B = MBUS;
    end
    
    if (b[15]) begin
      assign ALU_ADD = 1;
    end
    else begin
      assign ALU_ADD = 0;
    end
    
    if (b[14]) begin
      assign ALU_PASS_B = 1;
    end
    else begin
      assign ALU_PASS_B = 0;
    end
    
    if (b[13]) begin
      assign ADDRESS_BUS = MAR;
    end
    
    if (b[12]) begin
      assign DATA_BUS = MBR;
    end
    
    if (b[11]) begin
      assign IR = ABUS;
    end
    
    if (b[10]) begin
      assign MAR = ABUS;
    end
    
    if (b[9]) begin
      assign MBR = DATA_BUS;
    end
    
    if (b[8]) begin
      assign MBR = RBUS;
    end
    
    if (b[7]) begin
      assign MBUS = MBR;
    end
    
    if (b[6]) begin
      assign PC = 0;
    end
    
    if (b[5]) begin
      assign PC = PC + 2'b10;
    end
    
    if (b[4]) begin
      assign PC = ABUS;
    end
    
    if (b[3]) begin
      assign RW = 1;
    end
    else begin
      assign RW = 0;
    end
    
    if (b[2]) begin
      assign REQUEST = 1;
    end
    else begin
      assign REQUEST = 0;
    end
    
    if (b[1]) begin
      assign RBUS = AC;
    end
    
    if (b[0]) begin
      assign RBUS = ALU_RESULT;
    end
  
  */
  
endmodule

