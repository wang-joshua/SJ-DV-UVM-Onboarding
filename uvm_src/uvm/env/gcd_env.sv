/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_env.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Declare the gcd_agent, rst_agent, virtual sequencer, and scoreboard
*   3. Define the basic UVM Constructor
*   4. Instantiate the gcd_agent, rst_agent, virtual sequencer, and scoreboard (build_phase)
*   5. Connect your monitor analysis port to the scoreboard analysis import (connect_phase)
*   6. Connect virtual sequencer to gcd sequencer and reset sequencer (connect_phase)
-------------------------------------------------------------------------------------------------*/

class gcd_env extends uvm_env;

    `uvm_component_utils(gcd_env)

    gcd_agent        gcd_agnt;
    rst_agent        rst_agnt;
    virtual_sequencer v_seqr;
    gcd_sb           scoreboard;

    function new(string name = "gcd_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        gcd_agnt   = gcd_agent::type_id::create("gcd_agnt", this);
        rst_agnt   = rst_agent::type_id::create("rst_agnt", this);
        v_seqr     = virtual_sequencer::type_id::create("v_seqr", this);
        scoreboard = gcd_sb::type_id::create("scoreboard", this);
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        gcd_agnt.mon.item_collect_port.connect(scoreboard.item_collect_export);
        v_seqr.gcd_seqr = gcd_agnt.seqr;
        v_seqr.rst_seqr = rst_agnt.seqr;
    endfunction : connect_phase

endclass : gcd_env