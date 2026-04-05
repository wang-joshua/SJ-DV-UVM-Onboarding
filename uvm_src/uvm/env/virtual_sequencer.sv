/*-----------------------------------------------------------------------------------------------
* File Name     :   virtual_sequencer.sv
* Author        :   Matthew Nichols
* Date          :   1/2/2026

Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Declare the rst_sequencer and gcd_sequencer
*   3. Define the basic UVM Constructor (new)
-------------------------------------------------------------------------------------------------*/

class virtual_sequencer extends uvm_sequencer;

    `uvm_component_utils(virtual_sequencer)

    rst_sequencer rst_seqr;
    gcd_sequencer gcd_seqr;

    function new(string name = "virtual_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

endclass : virtual_sequencer