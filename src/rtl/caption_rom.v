// This is the ROM for the 'AGH48x64.png' image.
// The image size is 48 x 64 pixels.
// The input 'address' is a 12-bit number, composed of the concatenated
// 6-bit y and 6-bit x pixel coordinates.
// The output 'rgb' is 12-bit number with concatenated
// red, green and blue color values (4-bit each)
module caption_rom (
    input wire clk ,
    input wire [14:0] address,  // address = {addry[5:0], addrx[5:0]}
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