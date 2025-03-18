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
    assign uo_out[6:1]  = 6'b0;  // Example: ou_out is the sum of ui_in and uio_in
    assign uo_out[0] = clockDivider;
    assign uo_out[7] = &{ena, clk, rst_n, 1'b0} && &ui_in; 
    assign uio_out = 0;
    assign uio_oe  = 1;

  // List all unused inputs to prevent warnings
  //wire _unused = &{ena, clk, rst_n, 1'b0};

  wire reset, clockDivider;
  assign reset = ~rst_n;
  //assign 
    
    clockDivider clockDiv (
        .clk(clk),
        .reset(reset),
        .clockDivider(clockDivider)
    );
  
endmodule


module clockDivider (
    input clk,
    input reset,
    output reg dividedClock
);
    reg [1:0] count;

    always @ (posedge clk, posedge reset) begin
        if (reset) begin
            count <= 2'b01;
            dividedClock <= 1'b0;
        end else if (count == 2'b10) begin
            count <= 2'b01;
            dividedClock <= ~dividedClock;
        end else begin
            count <= count + 1'b1;
            dividedClock <= dividedClock;
        end
    end
endmodule
