module pacman(input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY ,   // Current pixel coordinates
					input [7:0]   keycode,				 // keycodes for handling presses
               output logic  is_pac,				// Whether current pixel belongs to ball or background
					output logic [9:0] PacX, PacY  
              );
				  
				  
   
    parameter [9:0] Pac_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Pac_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] Pac_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Pac_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Pac_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Pac_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] Pac_X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] Pac_Y_Step = 10'd1;      // Step size on the Y axis
    parameter [9:0] Pac_Size = 10'd16;        // Pac size
    
    logic [9:0] Pac_X_Pos, Pac_X_Motion, Pac_Y_Pos, Pac_Y_Motion;
    logic [9:0] Pac_X_Pos_in, Pac_X_Motion_in, Pac_Y_Pos_in, Pac_Y_Motion_in;
	 
	 
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
            Pac_X_Pos <= Pac_X_Center;
            Pac_Y_Pos <= Pac_Y_Center;
            Pac_X_Motion <= 10'd0;
            Pac_Y_Motion <= Pac_Y_Step;
        end
        else
        begin
            Pac_X_Pos <= Pac_X_Pos_in;
            Pac_Y_Pos <= Pac_Y_Pos_in;
            Pac_X_Motion <= Pac_X_Motion_in;
            Pac_Y_Motion <= Pac_Y_Motion_in;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        Pac_X_Pos_in = Pac_X_Pos;
        Pac_Y_Pos_in = Pac_Y_Pos;
        Pac_X_Motion_in = Pac_X_Motion;
        Pac_Y_Motion_in = Pac_Y_Motion;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Pac_Y_Pos - Pac_Size <= Pac_Y_Min 
            // If Pac_Y_Pos is 0, then Pac_Y_Pos - Pac_Size will not be -4, but rather a large positive number.
            if( Pac_Y_Pos + Pac_Size >= Pac_Y_Max )  // Pac is at the bottom edge, BOUNCE!
                Pac_Y_Motion_in = (~(Pac_Y_Step) + 1'b1);  // 2's complement.  
            else if ( Pac_Y_Pos <= Pac_Y_Min)  // Pac is at the top edge, BOUNCE!
                Pac_Y_Motion_in = Pac_Y_Step;
            // TODO: Add other boundary detections and handle keypress here.
				else if( Pac_X_Pos + Pac_Size >= Pac_X_Max )  // Pac is at the right edge, BOUNCE!
                Pac_X_Motion_in = (~(Pac_X_Step) + 1'b1);  // 2's complement.  
            else if ( Pac_X_Pos <= Pac_X_Min)  // Pac is at the left edge, BOUNCE!
                Pac_X_Motion_in = Pac_X_Step;
				
				else if (keycode==8'd26) //W
					begin
						Pac_Y_Motion_in = (~(Pac_Y_Step) + 1'b1);
						Pac_X_Motion_in = 0;
					end
				else if (keycode==8'd4) //A
					begin
						Pac_X_Motion_in = (~(Pac_X_Step) + 1'b1);
						Pac_Y_Motion_in = 0;
					end
				
				else if(keycode==8'd22) //S
					begin
						Pac_Y_Motion_in = Pac_Y_Step;
						Pac_X_Motion_in = 0;
					end
				
				else if (keycode==8'd7) //D
					begin
						Pac_X_Motion_in = Pac_X_Step;
						Pac_Y_Motion_in = 0;
					end
            // Update the Pac's position with its motion
            Pac_X_Pos_in = Pac_X_Pos + Pac_X_Motion;
            Pac_Y_Pos_in = Pac_Y_Pos + Pac_Y_Motion;
        end
        

    end
    
    // Compute whether the pixel corresponds to Pac or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
    assign DistX = DrawX - Pac_X_Pos;
    assign DistY = DrawY - Pac_Y_Pos;
    assign Size = Pac_Size;
    always_comb begin
//        if ( ( DistX*DistX + DistY*DistY) <= (Size*Size) ) 
		   if (DistX <= Pac_Size & DistX >= 0 & DistY <= Pac_Size & DistY >= 0)
		  begin
            is_pac = 1'b1;
				PacX = DrawX - Pac_X_Pos;
				PacY = DrawY - Pac_Y_Pos;
		  end
        else
		  begin
            is_pac = 1'b0;
				PacX = 0;
				PacY = 0;
        end
		  /* The Pac's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 
endmodule
