`timescale 10ns / 100ps

module slave_4(
    input clk,
    input [31:0]data,
    output reg ready,
    input valid,
    output  [31:0]data_out
    );
    reg  ready_tmp;
    reg [1:0]valid_tmp;
    reg [63:0]data_out_tmp;
    wire valid_neg;
    wire valid_pos;
  
initial 
    begin 
        data_out_tmp=0;
        ready = 1;
        valid_tmp = 0;
    end

always@(posedge clk)
    begin
        valid_tmp[0]<= valid;
        valid_tmp[1]<= valid_tmp[0];
    end

always@(negedge clk)
    begin
        ready_tmp<= ready;
    end

always@(posedge clk)
    begin
        data_out_tmp[31:0]<= data;
       // data_out_tmp[63:32]<=data_out_tmp[31:0]
    end

assign ready_1=ready&ready_tmp;
assign valid_neg = valid_tmp[1] & ~valid_tmp[0];
assign valid_pos = ~valid_tmp[1] & valid_tmp[0];


//握手,因为valid和ready都打了一拍，所以数据做了两级缓存
assign  data_out=data_out_tmp[63:32];
always@(posedge clk)
    begin
        if(valid_tmp[0] & ready_1)
            begin
                data_out_tmp[63:32] <= data_out_tmp[31:0];
            end
        else
            begin
                data_out_tmp[63:32] <=  data_out_tmp[63:32];
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