module dots(
	input  logic Clk,
	input  logic [9:0] kill_10, DrawX, DrawY,
	output logic [9:0] alive_10,
	output logic is_dots,
	output logic [3:0] dot_number,
	output logic [9:0] is_dot
	
);
	//logic [9:0] is_dot;

	 logic [9:0] DotX [9:0] = '{10'd489,10'd387,10'd41,10'd151,10'd424,10'd542,10'd222,10'd601,10'd221,10'd39};
	 logic [9:0] DotY [9:0] = '{10'd210,10'd115,10'd28,10'd302,10'd349,10'd392,10'd455,10'd162,10'd207,10'd158};

	
always_comb
begin
	if(is_dot)
	begin
	is_dots = 1'b1;
	end
	else
	begin
	is_dots = 1'b0;
	end
end
always_comb
begin
	unique case(is_dot)
	10'b0000000001: 
	dot_number = 4'd0;
	10'b0000000010: 
	dot_number = 4'd1;
	10'b0000000100: 
	dot_number = 4'd2;
	10'b0000001000: 
	dot_number = 4'd3;
	10'b0000010000: 
	dot_number = 4'd4;
	10'b0000100000: 
	dot_number = 4'd5;
	10'b0001000000: 
	dot_number = 4'd6;
	10'b0010000000: 
	dot_number = 4'd7;
	10'b0100000000: 
	dot_number = 4'd8;
	10'b1000000000: 
	dot_number = 4'd9;
	default:
	dot_number = 4'd0;
	endcase
end
	
	dot dot_0(.Clk, .kill(kill_10[0]), .alive(alive_10[0]),.is_dot(is_dot[0]),.*,.PosX(DotX[0]),.PosY(DotY[0]));
	dot dot_1(.Clk, .kill(kill_10[1]), .alive(alive_10[1]),.is_dot(is_dot[1]),.*,.PosX(DotX[1]),.PosY(DotY[1]));
	dot dot_2(.Clk, .kill(kill_10[2]), .alive(alive_10[2]),.is_dot(is_dot[2]),.*,.PosX(DotX[2]),.PosY(DotY[2]));
	dot dot_3(.Clk, .kill(kill_10[3]), .alive(alive_10[3]),.is_dot(is_dot[3]),.*,.PosX(DotX[3]),.PosY(DotY[3]));
	dot dot_4(.Clk, .kill(kill_10[4]), .alive(alive_10[4]),.is_dot(is_dot[4]),.*,.PosX(DotX[4]),.PosY(DotY[4]));
	dot dot_5(.Clk, .kill(kill_10[5]), .alive(alive_10[5]),.is_dot(is_dot[5]),.*,.PosX(DotX[5]),.PosY(DotY[5]));
	dot dot_6(.Clk, .kill(kill_10[6]), .alive(alive_10[6]),.is_dot(is_dot[6]),.*,.PosX(DotX[6]),.PosY(DotY[6]));
	dot dot_7(.Clk, .kill(kill_10[7]), .alive(alive_10[7]),.is_dot(is_dot[7]),.*,.PosX(DotX[7]),.PosY(DotY[7]));
	dot dot_8(.Clk, .kill(kill_10[8]), .alive(alive_10[8]),.is_dot(is_dot[8]),.*,.PosX(DotX[8]),.PosY(DotY[8]));
	dot dot_9(.Clk, .kill(kill_10[9]), .alive(alive_10[9]),.is_dot(is_dot[9]),.*,.PosX(DotX[9]),.PosY(DotY[9]));
endmodule: dots