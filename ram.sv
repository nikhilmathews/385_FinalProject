/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  frameRAM
(
		input [18:0] read_address,
		output logic [23:0] data_Out
);

// mem has width of 3 bits nd a total of 400 addresses
logic [23:0] tetris_I [0:399];

initial
begin
	 $readmemh("sprite_bytes/tetris_I.txt", tetris_I);
end


always_comb 
begin
	data_Out<= tetris_I[read_address];
end

endmodule
