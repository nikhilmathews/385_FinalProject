/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  maze_RAM
(
		input [18:0] read_address,
		output logic data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic mem [0:307199];

initial
begin
	 $readmemb("sprite_bytes/maze.txt", mem);
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule
