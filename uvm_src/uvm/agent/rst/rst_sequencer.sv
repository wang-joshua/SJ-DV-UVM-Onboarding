/*-----------------------------------------------------------------------------------------------
* File Name     :   rst_sequencer.sv
* Author        :   Matthew Nichols
* Date          :   1/2/2026

* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the basic UVM Constructor (new)
-------------------------------------------------------------------------------------------------*/

class rst_sequencer extends uvm_sequencer #(rst_seq_item);

    `uvm_component_utils(rst_sequencer)

    function new(string name = "rst_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

endclass : rst_sequencer