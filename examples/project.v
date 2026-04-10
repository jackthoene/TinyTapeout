`default_nettype none

module tt_um_yourname_counter (
    input  wire [7:0] ui_in,    // ui_in[0]: hold HIGH to pause counting
    output wire [7:0] uo_out,   // uo_out[3:0]: count value on lower 4 outputs
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n     // active-low reset (ASIC convention)
);
    reg [3:0] count;

    always @(posedge clk) begin
        if (!rst_n)              count <= 4'b0;
        else if (ena & ~ui_in[0]) count <= count + 1;
    end

    // All unused outputs must be explicitly assigned 0
    assign uo_out  = {4'b0, count};
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule
