module dots(
	input logic Clk,
	input logic [9:0] kill_10,
	output logic [9:0] alive_10
);

	dot dot_0(.Clk, .kill(kill_10[0]), .alive(alive_10[0]));
	dot dot_1(.Clk, .kill(kill_10[1]), .alive(alive_10[1]));
	dot dot_2(.Clk, .kill(kill_10[2]), .alive(alive_10[2]));
	dot dot_3(.Clk, .kill(kill_10[3]), .alive(alive_10[3]));
	dot dot_4(.Clk, .kill(kill_10[4]), .alive(alive_10[4]));
	dot dot_5(.Clk, .kill(kill_10[5]), .alive(alive_10[5]));
	dot dot_6(.Clk, .kill(kill_10[6]), .alive(alive_10[6]));
	dot dot_7(.Clk, .kill(kill_10[7]), .alive(alive_10[7]));
	dot dot_8(.Clk, .kill(kill_10[8]), .alive(alive_10[8]));
	dot dot_9(.Clk, .kill(kill_10[9]), .alive(alive_10[9]));
endmodule: dots