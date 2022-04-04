`timescale 10ns / 100ps

module slave_3(
    input clk,
    input [31:0]data,
    output reg ready,
    input valid,
    output  [31:0]data_out
    );
    
    reg valid_tmp;
    reg ready_tmp;
    reg [63:0]data_out_tmp;
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

always@(posedge clk)
    begin
        data_out_tmp[31:0]<= data;
    end

always@(posedge clk)
    begin
        ready_tmp<= ready;
    end

assign valid_neg = valid_tmp & ~valid;
assign valid_pos = ~valid_tmp & valid;


//握手
assign  data_out=data_out_tmp[63:32];
always@(posedge clk)
    begin
        if(valid & ready_tmp)
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