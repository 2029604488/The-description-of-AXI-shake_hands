`timescale 10ns / 100ps

module tb_4
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
    assign  #1.6 valid_ill = valid;
   assign  #1.1 ready_ill = ready;
    master_4 master_4_test(
        .clk(clk),
        .data(data),
        .valid(valid),
        .ready(ready_ill)
    );
    
    slave_4 slave_4_test(
        .clk(clk),
        .data(data),
        .valid(valid_ill),
        .ready(ready),
        .data_success(data_success)
    );
    
    
endmodule