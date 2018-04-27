module ghost(input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY ,   // Current pixel coordinates
					input [7:0]   keycode,				 // keycodes for handling presses
               output logic  is_ghost,				// Whether current pixel belongs to ball or background
					output logic [9:0] GhostX, GhostY,
					input logic up_wall_g, down_wall_g , left_wall_g, right_wall_g,
				   output logic [9:0] Ghost_X_Pos, Ghost_Y_Pos
              );
				  
				  
   
	enum logic[2:0] { Halted, 
					 up, 
					 down,
					 left,
					 right} Dir, Dir_in;

    parameter [9:0] Ghost_X_Center = 10'd25;  // Center position on the X axis
    parameter [9:0] Ghost_Y_Center = 10'd225;  // Center position on the Y axis
    parameter [9:0] Ghost_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Ghost_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Ghost_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Ghost_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] Ghost_X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] Ghost_Y_Step = 10'd1;      // Step size on the Y axis
    parameter [9:0] Ghost_Size = 10'd21;        // Ghost size
	 
    
    logic [9:0] Ghost_X_Motion, Ghost_Y_Motion;
    logic [9:0] Ghost_X_Pos_in, Ghost_X_Motion_in, Ghost_Y_Pos_in, Ghost_Y_Motion_in;
	 
	

	initial 
	begin
				Ghost_X_Pos <= Ghost_X_Center;
            Ghost_Y_Pos <= Ghost_Y_Center;
            Ghost_X_Motion <= 10'd0;
            Ghost_Y_Motion <= 10'd0;
				Dir <= Halted;
	end
	     //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            Ghost_X_Pos <= Ghost_X_Center;
            Ghost_Y_Pos <= Ghost_Y_Center;
            Ghost_X_Motion <= 10'd0;
            Ghost_Y_Motion <= 10'd0;
				Dir <= Halted;
        end
        else
        begin
            Ghost_X_Pos <= Ghost_X_Pos_in;
            Ghost_Y_Pos <= Ghost_Y_Pos_in;
            Ghost_X_Motion <= Ghost_X_Motion_in;
            Ghost_Y_Motion <= Ghost_Y_Motion_in;
				Dir <= Dir_in;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        Ghost_X_Pos_in = Ghost_X_Pos;
        Ghost_Y_Pos_in = Ghost_Y_Pos;
        Ghost_X_Motion_in = Ghost_X_Motion;
        Ghost_Y_Motion_in = Ghost_Y_Motion;
		  Dir_in = Dir;
        
        // Update position and motion only at rising edge of frame clock
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Ghost_Y_Pos - Ghost_Size <= Ghost_Y_Min 
            // If Ghost_Y_Pos is 0, then Ghost_Y_Pos - Ghost_Size will not be -4, but rather a large positive number.
//            if( Ghost_Y_Pos + Ghost_Size >= Ghost_Y_Max )  // Ghost is at the bottom edge, BOUNCE!
//                Ghost_Y_Motion_in = (~(Ghost_Y_Step) + 1'b1);  // 2's complement.  
//            else if ( Ghost_Y_Pos <= Ghost_Y_Min)  // Ghost is at the top edge, BOUNCE!
//                Ghost_Y_Motion_in = Ghost_Y_Step;
//            // TODO: Add other boundary detections and handle keypress here.
//				else if( Ghost_X_Pos + Ghost_Size >= Ghost_X_Max )  // Ghost is at the right edge, BOUNCE!
//                Ghost_X_Motion_in = (~(Ghost_X_Step) + 1'b1);  // 2's complement.  
//            else if ( Ghost_X_Pos <= Ghost_X_Min)  // Ghost is at the left edge, BOUNCE!
//                Ghost_X_Motion_in = Ghost_X_Step;

			  if (frame_clk_rising_edge)
			  begin		
				if (((keycode & 16'h00ff) == 16'h0052) | ((keycode & 16'hff00) == 16'h5200)) //Up
					begin
						//if(~up_wall_g)
						//begin
//						Pac_Y_Motion_in = (~(Pac_Y_Step) + 1'b1);
//						Pac_X_Motion_in = 0;
						Dir_in = up;
						//end
						//else
						//begin
//						Pac_Y_Motion_in = 0;
//						Pac_X_Motion_in = 0;
						//Dir_in = Halted;	
						//end
					end
				else if (((keycode & 16'h00ff) == 16'h0050) | ((keycode & 16'hff00) == 16'h5000)) //Left
					begin
						///if (~left_wall_g)			
						//begin
//						Pac_X_Motion_in = (~(Pac_X_Step) + 1'b1);
//						Pac_Y_Motion_in = 0;
						Dir_in = left;
						//end
						//else
						//begin
//						Pac_Y_Motion_in = 0;
//						Pac_X_Motion_in = 0;
//						Dir_in = Halted;	
//						end
					end
				
				else if(((keycode & 16'h00ff) == 16'h0051) | ((keycode & 16'hff00) == 16'h5100)) //Down
					begin
//						if (~down_wall_g) 
//						begin
//						Pac_Y_Motion_in = Pac_Y_Step;
//						Pac_X_Motion_in = 0;
						Dir_in = down;
//						end
//						else
//						begin
////						Pac_Y_Motion_in = 0;
////						Pac_X_Motion_in = 0;
//						Dir_in = Halted;	
//						end
					end
				
				else if (((keycode & 16'h00ff) == 16'h004f) | ((keycode & 16'hff00) == 16'h4f00)) //Right
					begin
//						if(~right_wall_g) begin
//						Pac_X_Motion_in = Pac_X_Step;
//						Pac_Y_Motion_in = 0;
						Dir_in = right;
//						end
//						else
//						begin
////						Pac_Y_Motion_in = 0;
////						Pac_X_Motion_in = 0;
//						Dir_in = Halted;	
//						end
					end
				

				if(Dir == up)
				begin
					if(~up_wall_g)
					begin
						Ghost_Y_Motion_in = (~(Ghost_Y_Step) + 1'b1);
						Ghost_X_Motion_in = 0;
					end
					else
					begin
						Ghost_X_Motion_in = 0;
						Ghost_Y_Motion_in = 0;
						//Dir_in = Halted;
					end
				end
				
				else if(Dir == down)
				begin
					if(~down_wall_g)
					begin
						Ghost_Y_Motion_in = Ghost_Y_Step;
						Ghost_X_Motion_in = 0;
					end
					else
					begin
						Ghost_X_Motion_in = 0;
						Ghost_Y_Motion_in = 0;
						//Dir_in = Halted;
					end
				end
				
				else if(Dir == right)
				begin
					if(~right_wall_g)
					begin
						Ghost_Y_Motion_in = 0;
						Ghost_X_Motion_in = Ghost_X_Step;
					end
					else
					begin
						Ghost_X_Motion_in = 0;
						Ghost_Y_Motion_in = 0;
						//Dir_in = Halted;
					end
				end
				
				else if(Dir == left)
					begin
					if(~left_wall_g)
					begin
						Ghost_Y_Motion_in = 0;
						Ghost_X_Motion_in = (~(Ghost_X_Step) + 1'b1);
					end
					else
					begin
						Ghost_X_Motion_in = 0;
						Ghost_Y_Motion_in = 0;
						//Dir_in = Halted;
					end	
					end
				else
				begin
						Ghost_Y_Motion_in = 0;
						Ghost_X_Motion_in = 0;
						//Dir_in = Halted;
				end
            // Update the Ghost's position with its motion
            Ghost_X_Pos_in = Ghost_X_Pos + Ghost_X_Motion;
            Ghost_Y_Pos_in = Ghost_Y_Pos + Ghost_Y_Motion;
        end
        

    end
    
    // Compute whether the pixel corresponds to Ghost or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
    assign DistX = DrawX - Ghost_X_Pos;
    assign DistY = DrawY - Ghost_Y_Pos;
    always_comb begin
//        if ( ( DistX*DistX + DistY*DistY) <= (Size*Size) ) 
		   if (DistX <= Ghost_Size & DistX >= 0 & DistY <= Ghost_Size & DistY >= 0)
		  begin
            is_ghost = 1'b1;
				GhostX = DrawX - Ghost_X_Pos;
				GhostY = DrawY - Ghost_Y_Pos;
		  end
        else
		  begin
            is_ghost = 1'b0;
				GhostX = 0;
				GhostY = 0;
        end
		  /* The Ghost's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 
endmodule
