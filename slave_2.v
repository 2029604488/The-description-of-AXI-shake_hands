`timescale 10ns / 100ps

module slave_2(
    input clk,
    input [31:0]data,
    output reg ready,
    input valid,
    output  [31:0]data_out
    );
    
    reg [1:0]valid_tmp;
    reg [63:0]data_out_tmp;
    wire valid_neg;
    wire valid_pos;
  
initial 
    begin 
        data_out_tmp=0;
        ready = 0;
        valid_tmp = 0;
    end
//这儿打两拍是为了取满足时序要求的上升沿
always@(posedge clk)
    begin
        valid_tmp[0]<= valid;
        valid_tmp[1]<= valid_tmp[0];
    end

always@(posedge clk)
    begin
        data_out_tmp[31:0]<= data;
    end

assign valid_neg = valid_tmp[1] & ~valid_tmp[0];
assign valid_pos = ~valid_tmp[1] & valid_tmp[0];


//握手,取的是valid打一拍后的，所以等于valid打一拍，数据做了一级缓存
assign  data_out=data_out_tmp[63:32];
always@(posedge clk)
    begin
        if(valid_tmp[0] & ready)
            begin
                data_out_tmp[63:32] <= data_out_tmp[31:0];
            end
        else
            begin
                data_out_tmp[63:32] <= 0;
            end
    end


always@(negedge clk)
    begin

        if(valid_pos)
            begin
                ready <= 1'd1;
            end
        if(valid_neg)
            begin
                ready <= 1'd0;
            end
    end


endmodule