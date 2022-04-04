`timescale 10ns / 100ps

module tb_1
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
            clk <= 1'd1;
        end

     
    always @(*)
        begin
          #clk_period clk <= ~clk;     
        end
    assign  valid_ill = valid;
   assign  ready_ill = ready;
    master_1 master_1_test(
        .clk(clk),
        .data(data),
        .valid(valid),
        .ready(ready_ill)
    );
    
    slave_1 slave_1_test(
        .clk(clk),
        .data(data),
        .valid(valid_ill),
        .ready(ready),
        .data_success(data_success)
    );
    
    
endmodule