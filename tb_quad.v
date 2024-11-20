`include "quad.v"
`include "decoder.v"
module tb_quad;

reg clk, dir, reset;
wire[7:0] count;
wire A, B;

quad enc(clk, dir, reset, A, B);
decoder dec(clk, A, B, reset, count); 

initial begin
    $dumpfile("tb_quad.vcd");
    $dumpvars(0, tb_quad);
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 1; dir = 0;
    #12 reset = 0;
    
    //#25 dir = 1; #10 dir = 0;
    #525 dir = 1; #10 dir = 0;
    #500 $finish;
end

endmodule