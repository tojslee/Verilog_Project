`timescale 1ns/1ps

// Memory module, you don't need to change any code here
// Testbench is included here (you can add more testbench you want)
// refer to : lecture note - page 15
module Memory(
  input [15:0] addrs_bus,
  input request,
  input rw, // 1:read, 0:write
  output reg wait_,
  input [15:0] data_bus_write,
  output [15:0] data_bus_read
);
  reg [15:0] mem[0:255];

  integer i;
  initial begin
    wait_ = 0;
    for  (i=0;i!=256;i=i+1) mem[i] = 0; // initialize all instructions as 0
    // Testbench instructions
    mem[0] = 16'b0000000000000100; //LD 4'b0100
    mem['b100] = 16'habcd;
  end

  assign data_bus_read = (rw) ? mem[addrs_bus[7:0]] : 'bz;

  always @ ( rw or data_bus_write ) begin
    if (rw==0) begin
      mem[addrs_bus] = data_bus_write;
    end
  end
endmodule
