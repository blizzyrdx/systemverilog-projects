// Connects all the UVM components together and starts the test
// example

  import uvm_pkg::*;          // Import the standard UVM library
  `include "uvm_macros.svh"   // Include standard UVM helper macros

  // Include your files in order of dependency
  `include "my_agent.sv"
  `include "my_env.sv"
  `include "my_test.sv"
endpackage