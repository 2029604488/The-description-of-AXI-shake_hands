`timescale 10ns / 100ps

module tb_3
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
    assign  valid_ill = valid;
   assign  #1.1 ready_ill = ready;
    master_3 master_3_test(
        .clk(clk),
        .data(data),
        .valid(valid),
        .ready(ready_ill)
    );
    
    slave_3 slave_3_test(
        .clk(clk),
        .data(data),
        .valid(valid_ill),
        .ready(ready),
        .data_success(data_success)
    );
    
    
endmodule