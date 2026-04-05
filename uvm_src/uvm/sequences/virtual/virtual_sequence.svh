/*-----------------------------------------------------------------------------------------------
* File Name     :   virtual_sequence.svh
* Author        :   Matthew Nichols
* Date          :   1/2/2026
-------------------------------------------------------------------------------------------------*/
class base_virtual_seq extends uvm_sequence;
  `uvm_object_utils(base_virtual_seq)

  // typed handle to the virtual sequencer
  `uvm_declare_p_sequencer(virtual_sequencer)

  function new(string name="base_virtual_seq");
    super.new(name);
  endfunction : new

  virtual task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) phase.raise_objection(this);
  endtask : pre_body

  virtual task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) phase.drop_objection(this);
  endtask : post_body

endclass : base_virtual_seq