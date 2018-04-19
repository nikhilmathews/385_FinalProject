//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper (             // Whether current pixel belongs to ball 
                       input					is_pac,                                       //   or background (computed in ball.sv)
                       input        [9:0] DrawX, DrawY,PacX, PacY,       // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
    logic [23:0] PacOut;  
	 logic MazeOut;
	 
	 pac_rightRAM pac_rram(.read_address(PacX + PacY*16), 
						.data_Out(PacOut));
						
	 maze_RAM maze_instance(.read_addressX(DrawX), .read_addressY(DrawY), .data_Out(MazeOut));
	 
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	 
	 
    // Assign color based on is_ball signal
    always_comb
    begin
		if (is_pac == 1'b1)
		begin
				Red = PacOut[23:16];
				Green = PacOut[15:8];
				Blue = PacOut[7:0];
		end
      else 
        begin
            // Background with maze
				if(MazeOut == 1'b0)
				begin
					Red =  8'h00;
					Green = 8'h00;
					Blue =  8'h00;
				end
				else
				begin
					Red =  8'h1f;
					Green = 8'h2b;
					Blue =  8'hdb;
				end
        end
    end 
    
endmodule
