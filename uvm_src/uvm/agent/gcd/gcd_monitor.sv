/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_monitor.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Declare handle to the gcd virtual interface, reset virtual interface, and gcd_seq_item
*   3. Create a UVM analysis port that writes monitored transactions to the scoreboard
*   4. Define the basic UVM Constructor (new)
*   5. Use uvm_config_db#()::get to connect the gcd virtual interface and reset virtual interface (connect_phase)
*   4. Define the logic to monitor transaction signals from the DUT (run_phase)
        |-> *Needs to be reset-sensitive to the reset interface
-------------------------------------------------------------------------------------------------*/

class gcd_monitor extends uvm_monitor;

    `uvm_component_utils(gcd_monitor)

    virtual gcd_if vif;
    virtual rst_if rst_vif;
    gcd_seq_item tr;

    uvm_analysis_port #(gcd_seq_item) item_collect_port;

    function new(string name = "gcd_monitor", uvm_component parent = null);
        super.new(name, parent);
        item_collect_port = new("item_collect_port", this);
    endfunction : new

    virtual function void connect_phase(uvm_phase phase);
        if (!uvm_config_db #(virtual gcd_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_type_name(), "Failed to get gcd_if from config_db")
        if (!uvm_config_db #(virtual rst_if)::get(this, "", "rst_vif", rst_vif))
            `uvm_fatal(get_type_name(), "Failed to get rst_if from config_db")
    endfunction : connect_phase

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.clk_i);

            if (rst_vif.rst_i) continue;

            if (vif.valid_i) begin
                tr = gcd_seq_item::type_id::create("tr");
                tr.data_a = vif.a_i;
                tr.data_b = vif.b_i;

                while (!vif.valid_o && !rst_vif.rst_i)
                    @(posedge vif.clk_i);

                if (!rst_vif.rst_i) begin
                    tr.result_gcd = vif.gcd_o;
                    item_collect_port.write(tr);
                end
            end
        end
    endtask : run_phase

endclass : gcd_monitor