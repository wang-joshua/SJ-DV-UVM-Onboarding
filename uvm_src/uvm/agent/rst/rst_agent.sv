/*-----------------------------------------------------------------------------------------------
* File Name     :   rst_agent.sv
* Author        :   Matthew Nichols
* Date          :   1/2/2026

Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the reset driver and reset sequencer
*   3. Define the basic UVM Constructor (new)
*   4. Use type_id::create to make the reset driver and reset sequencer (build_phase)
*   5. Instantiate and connect the reset driver seq_item_port to the reset sequencer seq_item_export (connect_phase)
-------------------------------------------------------------------------------------------------*/

class rst_agent extends uvm_agent;

    `uvm_component_utils(rst_agent)

    rst_driver    drv;
    rst_sequencer seqr;

    function new(string name = "rst_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv  = rst_driver::type_id::create("drv", this);
        seqr = rst_sequencer::type_id::create("seqr", this);
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction : connect_phase

endclass : rst_agent