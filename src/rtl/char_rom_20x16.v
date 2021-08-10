`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2021 13:46:07
// Design Name: 
// Module Name: draw_rect
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


module char_rom_20x16(
    output reg [6:0] char_code,
    input wire [8:0] char_xy
    );
    always@* begin
    
        case(char_xy)
            8'b0000_00000 : char_code = 7'h00;  //N
            8'b0000_00001 : char_code = 7'h00;  //N
            8'b0000_00010 : char_code = 7'h00;  //N
            8'b0000_00011 : char_code = 7'h00;  //N
            8'b0000_00100 : char_code = 7'h00;  //N
            8'b0000_00101 : char_code = 7'h00;  //N
            8'b0000_00110 : char_code = 7'h00;  //N
            8'b0000_00111 : char_code = 7'h4e;  //N
            8'b0000_01000 : char_code = 7'h4e;  //N
            8'b0000_01001 : char_code = 7'h4e;  //N
            8'b0000_01010 : char_code = 7'h4e;  //N
            8'b0000_01011 : char_code = 7'h4e;  //N
            8'b0000_01100 : char_code = 7'h4e;  //N
            8'b0000_01101 : char_code = 7'h4e;  //N
            8'b0000_01110 : char_code = 7'h4e;  //N
            8'b0000_01111 : char_code = 7'h00;  //N
            8'b0000_10000 : char_code = 7'h00;  //N
            8'b0000_10001 : char_code = 7'h00;  //N
            8'b0000_10010 : char_code = 7'h00;  //N
            8'b0000_10011 : char_code = 7'h00;  //N
            8'b0000_10100 : char_code = 7'h00;  //N

            8'b0001_00000 : char_code = 7'h4e;  //N
            8'b0001_00001 : char_code = 7'h4e;  //N
            8'b0001_00010 : char_code = 7'h4e;  //N
            8'b0001_00011 : char_code = 7'h4e;  //N
            8'b0001_00100 : char_code = 7'h4e;  //N
            8'b0001_00101 : char_code = 7'h4e;  //N
            8'b0001_00110 : char_code = 7'h4e;  //N
            8'b0001_00111 : char_code = 7'h4e;  //N
            8'b0001_01000 : char_code = 7'h4e;  //N
            8'b0001_01001 : char_code = 7'h4e;  //N
            8'b0001_01010 : char_code = 7'h4e;  //N
            8'b0001_01011 : char_code = 7'h4e;  //N
            8'b0001_01100 : char_code = 7'h4e;  //N
            8'b0001_01101 : char_code = 7'h4e;  //N
            8'b0001_01110 : char_code = 7'h4e;  //N
            8'b0001_01111 : char_code = 7'h4e;  //N
            8'b0001_10000 : char_code = 7'h4e;  //N
            8'b0001_10001 : char_code = 7'h4e;  //N
            8'b0001_10010 : char_code = 7'h4e;  //N
            8'b0001_10011 : char_code = 7'h4e;  //N
            8'b0001_10100 : char_code = 7'h4e;  //N

            8'b0010_00000 : char_code = 7'h4e;  //N
            8'b0010_00001 : char_code = 7'h4e;  //N
            8'b0010_00010 : char_code = 7'h4e;  //N
            8'b0010_00011 : char_code = 7'h4e;  //N
            8'b0010_00100 : char_code = 7'h4e;  //N
            8'b0010_00101 : char_code = 7'h4e;  //N
            8'b0010_00110 : char_code = 7'h4e;  //N
            8'b0010_00111 : char_code = 7'h4e;  //N
            8'b0010_01000 : char_code = 7'h4e;  //N
            8'b0010_01001 : char_code = 7'h4e;  //N
            8'b0010_01010 : char_code = 7'h4e;  //N
            8'b0010_01011 : char_code = 7'h4e;  //N
            8'b0010_01100 : char_code = 7'h4e;  //N
            8'b0010_01101 : char_code = 7'h4e;  //N
            8'b0010_01110 : char_code = 7'h4e;  //N
            8'b0010_01111 : char_code = 7'h4e;  //N
            8'b0010_10000 : char_code = 7'h4e;  //N
            8'b0010_10001 : char_code = 7'h4e;  //N
            8'b0010_10010 : char_code = 7'h4e;  //N
            8'b0010_10011 : char_code = 7'h4e;  //N
            8'b0010_10100 : char_code = 7'h4e;  //N

            8'b0011_00000 : char_code = 7'h4e;  //N
            8'b0011_00001 : char_code = 7'h4e;  //N
            8'b0011_00010 : char_code = 7'h4e;  //N
            8'b0011_00011 : char_code = 7'h4e;  //N
            8'b0011_00100 : char_code = 7'h4e;  //N
            8'b0011_00101 : char_code = 7'h4e;  //N
            8'b0011_00110 : char_code = 7'h4e;  //N
            8'b0011_00111 : char_code = 7'h4e;  //N
            8'b0011_01000 : char_code = 7'h4e;  //N
            8'b0011_01001 : char_code = 7'h4e;  //N
            8'b0011_01010 : char_code = 7'h4e;  //N
            8'b0011_01011 : char_code = 7'h4e;  //N
            8'b0011_01100 : char_code = 7'h4e;  //N
            8'b0011_01101 : char_code = 7'h4e;  //N
            8'b0011_01110 : char_code = 7'h4e;  //N
            8'b0011_01111 : char_code = 7'h4e;  //N
            8'b0011_10000 : char_code = 7'h4e;  //N
            8'b0011_10001 : char_code = 7'h4e;  //N
            8'b0011_10010 : char_code = 7'h4e;  //N
            8'b0011_10011 : char_code = 7'h4e;  //N
            8'b0011_10100 : char_code = 7'h4e;  //N
            
            8'b0100_00000 : char_code = 7'h4e;  //N
            8'b0100_00001 : char_code = 7'h4e;  //N
            8'b0100_00010 : char_code = 7'h4e;  //N
            8'b0100_00011 : char_code = 7'h4e;  //N
            8'b0100_00100 : char_code = 7'h4e;  //N
            8'b0100_00101 : char_code = 7'h4e;  //N
            8'b0100_00110 : char_code = 7'h4e;  //N
            8'b0100_00111 : char_code = 7'h4e;  //N
            8'b0100_01000 : char_code = 7'h4e;  //N
            8'b0100_01001 : char_code = 7'h4e;  //N
            8'b0100_01010 : char_code = 7'h4e;  //N
            8'b0100_01011 : char_code = 7'h4e;  //N
            8'b0100_01100 : char_code = 7'h4e;  //N
            8'b0100_01101 : char_code = 7'h4e;  //N
            8'b0100_01110 : char_code = 7'h4e;  //N
            8'b0100_01111 : char_code = 7'h4e;  //N
            8'b0100_10000 : char_code = 7'h4e;  //N
            8'b0100_10001 : char_code = 7'h4e;  //N
            8'b0100_10010 : char_code = 7'h4e;  //N
            8'b0100_10011 : char_code = 7'h4e;  //N
            8'b0100_10100 : char_code = 7'h4e;  //N

            8'b0101_00000 : char_code = 7'h4e;  //N
            8'b0101_00001 : char_code = 7'h4e;  //N
            8'b0101_00010 : char_code = 7'h4e;  //N
            8'b0101_00011 : char_code = 7'h4e;  //N
            8'b0101_00100 : char_code = 7'h4e;  //N
            8'b0101_00101 : char_code = 7'h4e;  //N
            8'b0101_00110 : char_code = 7'h4e;  //N
            8'b0101_00111 : char_code = 7'h4e;  //N
            8'b0101_01000 : char_code = 7'h4e;  //N
            8'b0101_01001 : char_code = 7'h4e;  //N
            8'b0101_01010 : char_code = 7'h4e;  //N
            8'b0101_01011 : char_code = 7'h4e;  //N
            8'b0101_01100 : char_code = 7'h4e;  //N
            8'b0101_01101 : char_code = 7'h4e;  //N
            8'b0101_01110 : char_code = 7'h4e;  //N
            8'b0101_01111 : char_code = 7'h4e;  //N
            8'b0101_10000 : char_code = 7'h4e;  //N
            8'b0101_10001 : char_code = 7'h4e;  //N
            8'b0101_10010 : char_code = 7'h4e;  //N
            8'b0101_10011 : char_code = 7'h4e;  //N
            8'b0101_10100 : char_code = 7'h4e;  //N

            8'b0110_00000 : char_code = 7'h4e;  //N
            8'b0110_00001 : char_code = 7'h4e;  //N
            8'b0110_00010 : char_code = 7'h4e;  //N
            8'b0110_00011 : char_code = 7'h4e;  //N
            8'b0110_00100 : char_code = 7'h4e;  //N
            8'b0110_00101 : char_code = 7'h4e;  //N
            8'b0110_00110 : char_code = 7'h4e;  //N
            8'b0110_00111 : char_code = 7'h4e;  //N
            8'b0110_01000 : char_code = 7'h4e;  //N
            8'b0110_01001 : char_code = 7'h4e;  //N
            8'b0110_01010 : char_code = 7'h4e;  //N
            8'b0110_01011 : char_code = 7'h4e;  //N
            8'b0110_01100 : char_code = 7'h4e;  //N
            8'b0110_01101 : char_code = 7'h4e;  //N
            8'b0110_01110 : char_code = 7'h4e;  //N
            8'b0110_01111 : char_code = 7'h4e;  //N
            8'b0110_10000 : char_code = 7'h4e;  //N
            8'b0110_10001 : char_code = 7'h4e;  //N
            8'b0110_10010 : char_code = 7'h4e;  //N
            8'b0110_10011 : char_code = 7'h4e;  //N
            8'b0110_10100 : char_code = 7'h4e;  //N

            8'b0111_00000 : char_code = 7'h4e;  //N
            8'b0111_00001 : char_code = 7'h4e;  //N
            8'b0111_00010 : char_code = 7'h4e;  //N
            8'b0111_00011 : char_code = 7'h4e;  //N
            8'b0111_00100 : char_code = 7'h4e;  //N
            8'b0111_00101 : char_code = 7'h4e;  //N
            8'b0111_00110 : char_code = 7'h4e;  //N
            8'b0111_00111 : char_code = 7'h4e;  //N
            8'b0111_01000 : char_code = 7'h4e;  //N
            8'b0111_01001 : char_code = 7'h4e;  //N
            8'b0111_01010 : char_code = 7'h4e;  //N
            8'b0111_01011 : char_code = 7'h4e;  //N
            8'b0111_01100 : char_code = 7'h4e;  //N
            8'b0111_01101 : char_code = 7'h4e;  //N
            8'b0111_01110 : char_code = 7'h4e;  //N
            8'b0111_01111 : char_code = 7'h4e;  //N
            8'b0111_10000 : char_code = 7'h4e;  //N
            8'b0111_10001 : char_code = 7'h4e;  //N
            8'b0111_10010 : char_code = 7'h4e;  //N
            8'b0111_10011 : char_code = 7'h4e;  //N
            8'b0111_10100 : char_code = 7'h4e;  //N
               
        endcase
    end
    
endmodule
