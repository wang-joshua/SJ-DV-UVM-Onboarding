package gcd_agent_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    typedef uvm_config_db#(virtual gcd_if) gcd_vif_config;
    import gcd_item_pkg::*;
    `include "gcd_monitor.sv"
    `include "gcd_driver.sv"
    `include "gcd_sequencer.sv"
    `include "gcd_agent.sv"
endpackage : gcd_agent_pkg