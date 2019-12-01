
module controller (
  input clk,
  input wait_, IR15, AC15, IR14,
  output [21:0] bus_controller
);
  wire [39:0] micro_instructions;
  wire [1:0] muxout;

  reg [3:0] state;
  reg [3:0] next_state;

  controllerROM rom(state, micro_instructions);

  always @ (posedge clk) state = next_state;

  // TODO: write codes to implement controller in lecture note, page 59
  
endmodule
