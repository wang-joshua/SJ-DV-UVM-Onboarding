/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_test_lib.sv
* Author        :   Andrew Chen and Matthew Nichols
* Date          :   1/5/2026
* Tasks to complete here:
*   1. Write more tests extended from the provided base test (gcd_base_test.svh)
*      to create different tests that run your different sequences.
-------------------------------------------------------------------------------------------------*/

// Example test that runs the simple example sequence
class simple_gcd_test extends base_gcd_test;

    // UVM Component Macro
    `uvm_component_utils(simple_gcd_test)

    // UVM Constructor
    function new(string name = "simple_gcd_test", uvm_component parent=null);
        super.new(name,parent);
    endfunction : new

    // Build phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        simple_gcd_with_reset_vseq vseq;

        phase.raise_objection(this);

        vseq = simple_gcd_with_reset_vseq::type_id::create("vseq");
        // Start on the virtual sequencer
        vseq.start(env.v_seqr);

        phase.drop_objection(this);
    endtask : run_phase

endclass : simple_gcd_test

// Example test that runs the reset during gcd sequence test
class reset_during_gcd_test extends base_gcd_test;

    // UVM Component Macro
    `uvm_component_utils(reset_during_gcd_test)

    // UVM Constructor
    function new(string name = "reset_during_gcd_test", uvm_component parent=null);
        super.new(name,parent);
    endfunction : new

    // Build phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        reset_during_gcd_vseq vseq;

        phase.raise_objection(this);

        vseq = reset_during_gcd_vseq::type_id::create("vseq");
        // Start on the virtual sequencer
        vseq.start(env.v_seqr);

        phase.drop_objection(this);
    endtask : run_phase

endclass : reset_during_gcd_test

// Test that runs the comprehensive coverage sequence
class comprehensive_gcd_test extends base_gcd_test;

    // UVM Component Macro
    `uvm_component_utils(comprehensive_gcd_test)

    // UVM Constructor
    function new(string name = "comprehensive_gcd_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction : new

    // Build phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        comprehensive_gcd_vseq vseq;

        phase.raise_objection(this);

        vseq = comprehensive_gcd_vseq::type_id::create("vseq");
        // Start on the virtual sequencer
        vseq.start(env.v_seqr);

        phase.drop_objection(this);
    endtask : run_phase

endclass : comprehensive_gcd_test