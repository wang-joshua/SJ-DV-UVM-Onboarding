/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_tb_top.sv
* Author        :   Andrew Chen
* Date          :   8/9/2025
-------------------------------------------------------------------------------------------------*/

module gcd_tb_top;

    timeunit 1ns;
    timeprecision 100ps;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import gcd_test_pkg::*;
    import gcd_seq_pkg::*;
    import gcd_agent_pkg::*;
    import gcd_env_pkg::*;
    import rst_agent_pkg::*;
    import rst_seq_pkg::*;

    logic clk = 0;

    always #10ns clk = ~clk;

    gcd_if if0(clk);
    rst_if if1(clk);
    gcd dut(
        .clk_i(clk),
        .rst_i(if1.rst_i),
        .valid_i(if0.valid_i),
        .a_i(if0.a_i),
        .b_i(if0.b_i),
        .gcd_o(if0.gcd_o),
        .valid_o(if0.valid_o));

    initial begin
        $shm_open("waves.shm");
        $shm_probe("AS");
        uvm_config_db #(virtual gcd_if)::set(uvm_root::get(), "*", "vif", if0);
        uvm_config_db #(virtual rst_if)::set(uvm_root::get(), "*", "rst_vif", if1);
        run_test();
    end

endmodule : gcd_tb_top
