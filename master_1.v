`timescale 10ns / 100ps

 module master_1(
    input  clk,
    output [31:0]data,
    output reg valid,
    input  ready
);
    reg [31:0]data_source;
    reg [31:0]data_tmp;

initial 
    begin 
        data_source = 0;
        data_tmp=0;
    end

assign data = data_tmp;

always@(posedge clk)
    begin
        data_source <= data_source + 1;
    end
/*
always@(posedge clk)
    begin
        if(data_source & 32'b1000)
        begin 
            valid <= 1;
            data_tmp <= data_source;
        end
        else 
        begin
           valid <= 0;
           data_tmp <= 0;
        end
    end
*/
//持续发数据
always@(posedge clk)
begin
    if(data_source)
        begin 
            valid <= 1;
            data_tmp <= data_source;
        end
    else
        begin
            valid <= 0;
            data_tmp <= 0;
        end
end
endmodule