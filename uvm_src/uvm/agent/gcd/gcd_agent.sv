/*-----------------------------------------------------------------------------------------------
* File Name     :   agent_template.sv
* Author        :   Andrew Chen
* Date          :   8/9/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Declare the monitor, sequencer, and driver components
*   3. Define the basic UVM Constructor
*   4. Instantiate your driver, monitor, and sequencer based on is_active
*   5. Connect your sequencer to your driver based on is_active
-------------------------------------------------------------------------------------------------*/

class gcd_agent extends uvm_agent;

    `uvm_component_utils(gcd_agent)

    gcd_monitor   mon;
    gcd_sequencer seqr;
    gcd_driver    drv;

    function new(string name = "gcd_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (get_is_active() == UVM_ACTIVE) begin
            drv  = gcd_driver::type_id::create("drv", this);
            seqr = gcd_sequencer::type_id::create("seqr", this);
        end
        mon = gcd_monitor::type_id::create("mon", this);
    endfunction : build_phase

    virtual function void connect_phase(uvm_phase phase);
        if (get_is_active() == UVM_ACTIVE)
            drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction : connect_phase

endclass : gcd_agent