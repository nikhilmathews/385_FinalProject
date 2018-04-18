/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  maze_RAM
(
		input [18:0] read_address,
		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:306999];

initial
begin
	 $readmemh("sprite_bytes/maze.txt", mem);
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule
