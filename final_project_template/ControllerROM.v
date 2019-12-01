module controllerROM (
  input [3:0] state,
  output reg [39:0] out
);

  always @ ( out or state ) begin
    case (state)
    // TODO: refer to lecture note, page 58
    4'b0000: out = 40'b0000010001000100010000000000000001000000;













    endcase
  end

endmodule