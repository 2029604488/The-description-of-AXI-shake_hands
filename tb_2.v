`timescale 10ns / 100ps

module tb_2
#(
    parameter clk_period = 5);
    wire  [31:0]data;
    wire  valid;
    wire  ready;
    wire  data_success;
    reg clk;

    wire valid_ill;
    wire ready_ill;

    initial
        begin
            clk <= 1;
        end

     
    always @(*)
        begin
          #clk_period clk <= ~clk;     
        end
    assign #1.1 valid_ill = valid;
   assign  ready_ill = ready;
    master_2 master_2_test(
        .clk(clk),
        .data(data),
        .valid(valid),
        .ready(ready_ill)
    );
    
    slave_2 slave_2_test(
        .clk(clk),
        .data(data),
        .valid(valid_ill),
        .ready(ready),
        .data_success(data_success)
    );
    
    
endmodule