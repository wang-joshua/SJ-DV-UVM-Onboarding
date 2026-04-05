/*-----------------------------------------------------------------------------------------------
* File Name     :   rst_if.sv
* Author        :   Matthew Nichols
* Date          :   1/2/2026

* This file defines the reset interface for the DUT
-------------------------------------------------------------------------------------------------*/
interface rst_if (input logic clk_i);
timeunit 1ns;
timeprecision 100ps;

    logic rst_i;

endinterface : rst_if