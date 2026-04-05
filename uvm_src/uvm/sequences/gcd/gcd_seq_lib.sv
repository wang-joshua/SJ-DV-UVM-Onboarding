/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_seq_lib.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Write more sequences extended from the provided base sequence (gcd_sequence.svh)
*      to create different test cases (ex. edge cases, randomized tests, etc) with the goal
*      to reach at least 96% coverage.
*
* A simple sequence that runs one randomized transaction is provided
-------------------------------------------------------------------------------------------------*/

// Example sequence extending the base sequence
class simple_gcd_seq extends base_gcd_seq;

    // UVM Component Macro
    `uvm_object_utils(simple_gcd_seq)

    // UVM Constructor
    function new(string name = "simple_gcd_seq");
        super.new(name);
    endfunction : new

    // Sequence body definition
    virtual task body();
        // Example transaction generation logic
        // This is where you would define the specific sequence behavior
        `uvm_info(get_type_name(), "Executing simple sequence", UVM_LOW)
        `uvm_do(req)
    endtask : body

endclass : simple_gcd_seq

// Runs 20 randomized transactions to cover both a>b and b>a subtraction branches
class repeated_gcd_seq extends base_gcd_seq;

    `uvm_object_utils(repeated_gcd_seq)

    function new(string name = "repeated_gcd_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Executing repeated GCD sequence (20 transactions)", UVM_LOW)
        repeat(20) begin
            `uvm_do(req)
        end
    endtask : body

endclass : repeated_gcd_seq

// Tests equal inputs: a == b -> COMPUTING immediately sees a_reg==b_reg -> DONE in 1 cycle
class equal_inputs_seq extends base_gcd_seq;

    `uvm_object_utils(equal_inputs_seq)

    function new(string name = "equal_inputs_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Executing equal inputs GCD sequence", UVM_LOW)
        `uvm_do_with(req, { req.data_a == req.data_b; })
    endtask : body

endclass : equal_inputs_seq

// Tests max difference inputs to exercise many COMPUTING cycles
class max_diff_seq extends base_gcd_seq;

    `uvm_object_utils(max_diff_seq)

    function new(string name = "max_diff_seq");
        super.new(name);
    endfunction : new

    virtual task body();
        `uvm_info(get_type_name(), "Executing max difference GCD sequence", UVM_LOW)
        `uvm_do_with(req, { req.data_a == 8'd255; req.data_b == 8'd1; })
        `uvm_do_with(req, { req.data_a == 8'd1;   req.data_b == 8'd255; })
        `uvm_do_with(req, { req.data_a == 8'd255; req.data_b == 8'd255; })
    endtask : body

endclass : max_diff_seq