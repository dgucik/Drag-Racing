// This is the ROM for the 'AGH48x64.png' image.
// The image size is 48 x 64 pixels.
// The input 'address' is a 12-bit number, composed of the concatenated
// 6-bit y and 6-bit x pixel coordinates.
// The output 'rgb' is 12-bit number with concatenated
// red, green and blue color values (4-bit each)
module caption_rom (
    input wire clk ,
    input wire [14:0] address,  // address = {addry[5:0], addrx[5:0]}
    output reg pixel_bit
);


reg rom [0:22015];

initial $readmemh("lose_caption_rom.data", rom); 

always @(posedge clk)
    pixel_bit <= rom[address];

endmodule