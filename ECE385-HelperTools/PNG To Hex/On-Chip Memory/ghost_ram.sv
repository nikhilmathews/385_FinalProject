/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  ghost_rightRAM
(
		input [18:0] read_address,
		output logic [23:0] data_Out
);
parameter [9:0] size = 10'd21;

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:size*size-1];

initial
begin
	 $readmemh("sprite_bytes/ghost_red_right.txt", mem);
end


always_comb
 begin
	data_Out<= mem[read_address];
end

endmodule
