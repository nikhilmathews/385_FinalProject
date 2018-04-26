module dot(
	input logic Clk,
	input logic [9:0]PosX, PosY, DrawX, DrawY,
	input logic kill,
	output logic alive, is_dot
);
initial
begin
alive = 1'b1;
end


int DistX, DistY, Size;
assign DistX = DrawX - PosX;
assign DistY = DrawY - PosY;
assign Size = 3'd5;
    always_comb 
	 begin
        if ( ( DistX*DistX + DistY*DistY) <= (Size*Size) ) 
            is_dot = 1'b1;
        else
            is_dot = 1'b0;
    end

always_ff @(posedge Clk)
begin
	if(kill)
	begin
	alive = 1'b0;
	end
end
endmodule: dot