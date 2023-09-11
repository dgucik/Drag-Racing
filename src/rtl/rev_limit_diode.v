//////////////////////////////////////////////////////////////////////////////////
// Company: AGH University of Science and Technology
// Engineer: Patryk Kocinski
// 
// Create Date:
// Design Name:
// Module Name: rev_limit_diode
// Project Name: Drag-Racing
// Target Devices: Basys3
// Tool Versions: Vivado 2017.3
// Description: This is rev_limit_diode module of Drag Racing game for Basys3 platform
// 
// Dependencies: 
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments: -
// 
//////////////////////////////////////////////////////////////////////////////////

module rev_limit_diode(
    input wire [13:0] rpm,
    output reg diode
    
    );
    always @* begin
        if(rpm >= 10800) diode = 1;
        else diode = 0;
    end
endmodule
