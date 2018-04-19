module legalMoves(input logic[9:0] DrawX, DrawY
);


maze_RAM maze_instance(.read_addressX(DrawX), .read_addressY(DrawY), .data_Out(is_wall));
