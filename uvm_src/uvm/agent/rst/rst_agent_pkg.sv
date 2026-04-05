package rst_agent_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    typedef uvm_config_db#(virtual rst_if) rst_vif_config;
    import rst_item_pkg::*;
    `include "rst_driver.sv"
    `include "rst_sequencer.sv"
    `include "rst_agent.sv"
endpackage : rst_agent_pkg