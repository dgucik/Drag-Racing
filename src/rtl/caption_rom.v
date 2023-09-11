//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Daniel Gucik
// 
// Create Date:
// Design Name:
// Module Name: caption_rom
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is caption_rom module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module caption_rom (
    input wire clk ,
    input wire [14:0] address,
    output reg [1:0] pixel_bit
);

    reg rom_1 [0:22015];
    reg rom_2 [0:22015];

    initial $readmemh("lose_caption_rom.data", rom_1);
    initial $readmemh("win_caption_rom.data", rom_2);  

    always @(posedge clk) begin
        pixel_bit[0] <= rom_1[address];
        pixel_bit[1] <= rom_2[address];
    end
endmodule