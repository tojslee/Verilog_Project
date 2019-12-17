`timescale 1ns/1ps

// Memory module, you don't need to change any code here
// refer to : lecture note - page 15
module Memory(
  input [15:0] addrs_bus,
  input request,
  input rw, // 1:read, 0:write
  output reg wait_,
  input [15:0] data_bus_write,
  output [15:0] data_bus_read
);
  reg [7:0] mem[0:255];

  integer i;
  initial begin
    wait_ = 1;
    for  (i=0;i!=256;i=i+1) mem[i] = 0; // initialize all instructions as 0
    mem['h0] = 8'b00000000;
    mem['h1] = 8'b10000010;
    mem['h2] = 8'b10000000;
    mem['h3] = 8'b10000100;
    mem['h4] = 8'b01000000;
    mem['h5] = 8'b10000010;
    mem['h6] = 8'b10000000;
    mem['h7] = 8'b10000000;
    mem['h8] = 8'b01000000;
    mem['h9] = 8'b10000000;
    mem['ha] = 8'b00000000;
    mem['hb] = 8'b10000110;
    mem['hc] = 8'b10000000;
    mem['hd] = 8'b10001000;
    mem['he] = 8'b01000000;
    mem['hf] = 8'b10000110;
    mem['h10] = 8'b11000000;
    mem['h11] = 8'b00000000;
    mem['h12] = 8'b00000000;
    mem['h13] = 8'b10000000;

    mem[8'b10000000] = 8'h00;
    mem[8'b10000001] = 8'h00;
    mem[8'b10000010] = 8'h00;
    mem[8'b10000011] = 8'h00;
    mem[8'b10000100] = 8'h00;
    mem[8'b10000101] = 8'h01;
    mem[8'b10000110] = 8'hFF;
    mem[8'b10000111] = 8'hFC;
    mem[8'b10001000] = 8'h00;
    mem[8'b10001001] = 8'h01;
  end

  assign data_bus_read[15:8] = (rw) ? mem[addrs_bus[7:0]] : 'bz;
  assign data_bus_read[7:0] = (rw) ? mem[addrs_bus[7:0]+1] : 'bz;

  always @ ( request or rw or data_bus_write ) begin
    if ( request ) begin
      if ( ~rw ) begin
        mem[addrs_bus] = data_bus_write[15:8];
        mem[addrs_bus+1] = data_bus_write[7:0];
      end
      wait_ = 0;
    end
    else wait_ = 1;
  end
endmodule