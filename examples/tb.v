`default_nettype none
`timescale 1ns/1ps

module tb;
    reg        clk    = 0;
    reg        rst_n  = 0;
    reg        ena    = 1;
    reg  [7:0] ui_in  = 8'b0;
    reg  [7:0] uio_in = 8'b0;
    wire [7:0] uo_out, uio_out, uio_oe;

    tt_um_yourname_counter dut (
        .ui_in(ui_in), .uo_out(uo_out),
        .uio_in(uio_in), .uio_out(uio_out), .uio_oe(uio_oe),
        .ena(ena), .clk(clk), .rst_n(rst_n)
    );

    always #5 clk = ~clk;   // 100 MHz clock (10 ns period)

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
        #20 rst_n = 1;        // release reset after 2 cycles

        #200;
        $display("After 20 cycles (expect 4): count = %0d", uo_out[3:0]);

        ui_in[0] = 1;         // pause
        #100;
        $display("After pause (unchanged): count = %0d", uo_out[3:0]);
        ui_in[0] = 0;

        #50 rst_n = 0;        // mid-run reset
        #20 rst_n = 1;
        $display("After reset (expect 0): count = %0d", uo_out[3:0]);

        #100 $finish;
    end
endmodule
