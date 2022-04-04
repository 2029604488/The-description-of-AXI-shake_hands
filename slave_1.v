`timescale 10ns / 100ps

module slave_1(
    input clk,
    input [31:0]data,
    output reg ready,
    input valid,
    output  [31:0]data_out
    );
    
    reg valid_tmp;
    reg [31:0]data_out_tmp;
    wire valid_neg;
    wire valid_pos;
  
initial 
    begin 
        data_out_tmp=0;
        ready = 0;
        valid_tmp = 0;
    end

always@(posedge clk)
    begin
        valid_tmp<= valid;
    end

assign data_out=data_out_tmp;
assign valid_neg = valid_tmp & ~valid;
assign valid_pos = ~valid_tmp & valid;


//握手，取的是原valid，相当于valid没打拍，数据没有丢失
always@(posedge clk)
    begin
        if(valid & ready)
            begin
                data_out_tmp <= data;
            end
        else
            begin
                data_out_tmp <= 0;
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