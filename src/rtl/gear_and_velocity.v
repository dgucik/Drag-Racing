`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2021 05:21:43
// Design Name: 
// Module Name: gear_and_velocity
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module gear_and_velocity(
    input wire clk,
    input wire rst,
    input wire kb_key_pressed_tick,
    input wire kb_key_pressed,
    input wire reset_status,
    input wire enable_controller_status,
    output wire [31:0] position,
    output wire flag_for_readline_diode_in_cockpit,
    output wire [1:0] current_gear,
    output wire slow_clk_out
    );
    
    wire clk100Hz, clk10Hz;
    
    //gear_shifter
    wire [1:0] sh_gear;
    
    //rpm
    wire [13:0] rpm_rpm_out;
    wire [1:0] rpm_gear_out;
    
    //rpm_to_velocity
    wire [6:0] d_position;
    wire [31:0] xposition;
    
    //mux
    wire mux_key_posedge, mux_key_pressed;
    
    clk_divide #(.DIVISOR(650000)) u_timer_100Hz(
    .clk_in(clk),
    .clk_out(clk100Hz)
    );
    
    clk_divide #(.DIVISOR(6500000)) u_timer_10Hz(
    .clk_in(clk),
    .clk_out(clk10Hz)
    );
    
    gear_shifter u_gear_shifter(
    .clk(clk),
    .rst(rst),
    .reset_status(reset_status),
    .keyboard_in_posedge(mux_key_posedge),
    .gear(sh_gear)
    );
    
    rpm u_rpm(
    .clk100Hz(clk100Hz),
    .rst(rst),
    .reset_status(reset_status),
    .gear_in(sh_gear),
    .gas_key(mux_key_pressed),
    .rpm(rpm_rpm_out),
    .gear_out(rpm_gear_out),
    .flag_for_readline_diode_in_cockpit(flag_for_readline_diode_in_cockpit)
    );
    
    rpm_to_velocity u_rpm_to_dposition(
    .clk100Hz(clk100Hz),
    .rst(rst),
    .reset_status(reset_status),
    .rpm(rpm_rpm_out),
    .gear(rpm_gear_out),
    .d_position(d_position)
    );
    
    position_adder u_position_adder(
    .clk10Hz(clk10Hz),
    .rst(rst),
    .reset_status(reset_status),
    .d_position(d_position),
    .position(xposition)
    );
    
    mux2to1 u_mux2to1(
    .D0(0),
    .D1(kb_key_pressed_tick),
    .D2(kb_key_pressed),
    .S(enable_controller_status),
    .Y1(mux_key_posedge),
    .Y2(mux_key_pressed)
    );
    
    assign position = xposition;
    assign current_gear = sh_gear;
    assign slow_clk_out = clk10Hz;

endmodule
