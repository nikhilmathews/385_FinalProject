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
							  input Clk,
                       input					is_pac,is_wall, is_ghost,                       //   or background (computed in ball.sv)
                       input        [9:0] DrawX, DrawY,PacX, PacY, GhostX, GhostY,      // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
							  output logic [9:0] kill_10,alive_10,is_dot,
							  output logic [3:0] score

                     );
    
    logic [7:0] Red, Green, Blue;
    logic [23:0] PacOut, GhostOut;  
	 logic update_score;
	 logic endgame = 0;
	 logic endf = 0;
	 logic is_end_font;
	 logic [9:0] pacsize = 18;
	 
    always_ff @ (posedge Clk) begin
	 if (update_score)
	 begin
		score = score + 1;
		if(score == 10)
			endf = 1;
	end
	 if (endgame)
		endf = 1;
	 end
	 
	 initial
	 begin
		score = 4'd0;
	 end
	 
	 //logic [9:0] kill_10,alive_10;
	 logic is_dots;							
	 logic [3:0] dot_number;
	 
	 end_RAM eram(.data_Out(is_end_font), .read_addressX(10'd640-DrawX), .read_addressY(10'd480-DrawY));
	 pac_rightRAM pac_rram(.read_address(PacX + PacY*pacsize), 
						.data_Out(PacOut));
						
	 ghost_rightRAM ghost_rram(.read_address(GhostX + GhostY*pacsize), 
						.data_Out(GhostOut));					
						
	 dots dots_instance(.*);
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	 
	 
    // Assign color based on is_ball signal
    always_comb
    begin
	 endgame = 0;
	 update_score = 0;
	 kill_10 = 10'd0;
	  if (endf)
	  begin
	   if (is_end_font)
		begin
		Red = 8'h00;
		Green = 8'h00;
		Blue = 8'hff;
		end
		else
		begin
		Red = 8'h00;
		Green = 8'h00;
		Blue = 8'h00;
		end
	  end
	  else if (is_ghost == 1'b1)
		begin
		if(is_pac == 1'b1)
			begin
				endgame = 1;
				Red = GhostOut[23:16];
				Green = GhostOut[15:8];
				Blue = GhostOut[7:0]; /*Fix this */
			end
			else
			begin
				Red = GhostOut[23:16];
				Green = GhostOut[15:8];
				Blue = GhostOut[7:0];
			end
		end
		else if(is_dots & alive_10[dot_number])
		begin
			if(is_pac == 1'b1)
			begin
				kill_10[dot_number] = 1'b1;
				update_score = 1;
				Red = PacOut[23:16];
				Green = PacOut[15:8];
				Blue = PacOut[7:0];
			end
			else
			begin
					Red =  8'h00;
					Green = 8'hff;
					Blue =  8'haa;
			end
		end
		else if (is_pac == 1'b1)
		begin
				Red = PacOut[23:16];
				Green = PacOut[15:8];
				Blue = PacOut[7:0];
		end
      else 
        begin
            // Background with maze
				if(is_wall == 1'b0)
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
