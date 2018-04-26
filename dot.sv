module dot(
	input logic Clk,
	input logic kill,
	output logic alive
);
initial
begin
alive = 1'b1;
end

always_ff(@posedge Clk)
begin
	if(kill)
	begin
	alive = 1'b0;
	end
end
endmodule: dot