/*-----------------------------------------------------------------------------------------------
* File Name     :   rst_seq_item.sv
* Author        :   Matthew Nichols
* Date          :   1/2/2026
-------------------------------------------------------------------------------------------------*/
class rst_seq_item extends uvm_sequence_item;
    int cycles;

    `uvm_object_utils(rst_seq_item)

    function new(string name="rst_seq_item");
        super.new(name);
    endfunction : new

endclass : rst_seq_item