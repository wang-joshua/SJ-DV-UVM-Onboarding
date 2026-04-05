/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_driver.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Declare the gcd virtual interface andd reset virtual interface
*   2. Define the basic UVM Constructor (new)
*   3. Use uvm_config_db#()::get to connect the gcd virtual interface and reset interface (connect_phase)
*   4. Define the logic to drive transaction signals onto the DUT (run_phase)
        |-> *Needs to be reset sensitive to the reset virtual interface
-------------------------------------------------------------------------------------------------*/

class gcd_driver extends uvm_driver #(gcd_seq_item);

    `uvm_component_utils(gcd_driver)

    virtual gcd_if vif;
    virtual rst_if rst_vif;

    function new(string name = "gcd_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual function void connect_phase(uvm_phase phase);
        if (!uvm_config_db #(virtual gcd_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Failed to get gcd_if from config_db")
        if (!uvm_config_db #(virtual rst_if)::get(this, "", "rst_vif", rst_vif))
            `uvm_fatal(get_type_name(), "Failed to get rst_if from config_db")
    endfunction : connect_phase

    virtual task run_phase(uvm_phase phase);
        vif.valid_i <= 0;
        vif.a_i     <= 0;
        vif.b_i     <= 0;

        forever begin
            seq_item_port.get_next_item(req);

            @(posedge vif.clk_i);
            vif.a_i     <= req.data_a;
            vif.b_i     <= req.data_b;
            vif.valid_i <= 1;

            @(posedge vif.clk_i);
            vif.valid_i <= 0;

            while (!vif.valid_o && !rst_vif.rst_i)
                @(posedge vif.clk_i);

            seq_item_port.item_done();
        end
    endtask : run_phase

endclass : gcd_driver