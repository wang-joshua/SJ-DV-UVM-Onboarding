/*-----------------------------------------------------------------------------------------------
* File Name     :   rst_driver.sv
* Author        :   Matthew Nichols
* Date          :   1/2/2026

Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the virtual reset interface
*   3. Define the basic UVM Constructor (new)
*   4. Use uvm_config_db#()::get to find the virtual reset interface (build_phase)
*   5. Define the logic to drive transaction signals onto the DUT (run_phase)
-------------------------------------------------------------------------------------------------*/

class rst_driver extends uvm_driver #(rst_seq_item);

    `uvm_component_utils(rst_driver)

    virtual rst_if rst_vif;

    function new(string name = "rst_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual rst_if)::get(this, "", "rst_vif", rst_vif))
            `uvm_fatal(get_type_name(), "Failed to get rst_if from config_db")
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        rst_vif.rst_i <= 0;

        forever begin
            seq_item_port.get_next_item(req);
            rst_vif.rst_i <= 1;
            repeat(req.cycles) @(posedge rst_vif.clk_i);
            rst_vif.rst_i <= 0;
            seq_item_port.item_done();
        end
    endtask : run_phase

endclass : rst_driver