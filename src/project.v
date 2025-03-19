/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
    /*
    assign uo_out[6:1]  = 6'b0;  // Example: ou_out is the sum of ui_in and uio_in
    assign uo_out[0] = clockDivider;
    assign uo_out[7] = &{ena, clk, rst_n, 1'b0} && &ui_in; 
    assign uio_out = 0;
    assign uio_oe  = 1;
    */
    
  // List all unused inputs to prevent warnings
  wire _unused = |{ena, clk, rst_n, 1'b0};

    wire [3:0] a, b, sum;
    wire cin, carry;
  //assign 
    assign a = ui_in[7:4];
    assign b = ui_in[3:0];
    assign cin = uio_in[0];
    assign uio_oe = {7'b1111111, 1'b0};
    assign uo_out = {3'b000, carry, sum};
    assign uio_out = 8'b0000_0000;
    
    simpleAdder add1 (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .carry(carry)
    );
  
endmodule


module simpleAdder (
    input [3:0] a,
    input [3:0] b,
    input cin,
    output reg [3:0] sum,
    output reg carry
);
    always @ (*)
        {carry, sum} = a + b + cin;
    
endmodule
