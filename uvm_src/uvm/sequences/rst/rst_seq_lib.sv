/*-----------------------------------------------------------------------------------------------
* File Name     :   rst_seq_lib.sv
* Author        :   Matthew Nichols
* Date          :   1/2/2026

* A simple sequence that asserts a reset for a specified number of cycles
-------------------------------------------------------------------------------------------------*/
class simple_reset_seq extends uvm_sequence #(rst_seq_item);

    `uvm_object_utils(simple_reset_seq)

    function new(string name = "simple_reset_seq");
        super.new(name);
    endfunction

    virtual task body();
        rst_seq_item r;

        `uvm_info(get_type_name(), "Asserting reset", UVM_LOW)

        r = rst_seq_item::type_id::create("r");
        r.cycles = 10;

        start_item(r);
        finish_item(r);
    endtask

endclass