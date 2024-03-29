
`timescale 1 ns / 1 ps

	module harness_axi_ip_v1_0_S00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 9
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line

		// Global Clock Signal
		input wire  S_AXI_ACLK,
		// Global Reset Signal. This Signal is Active LOW
		input wire  S_AXI_ARESETN,
		// Write address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		// Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_AWPROT,
		// Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
		input wire  S_AXI_AWVALID,
		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
		output wire  S_AXI_AWREADY,
		// Write data (issued by master, acceped by Slave) 
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		// Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.    
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		// Write valid. This signal indicates that valid write
    		// data and strobes are available.
		input wire  S_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    		// can accept the write data.
		output wire  S_AXI_WREADY,
		// Write response. This signal indicates the status
    		// of the write transaction.
		output wire [1 : 0] S_AXI_BRESP,
		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
		output wire  S_AXI_BVALID,
		// Response ready. This signal indicates that the master
    		// can accept a write response.
		input wire  S_AXI_BREADY,
		// Read address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_ARPROT,
		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
		input wire  S_AXI_ARVALID,
		// Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
		output wire  S_AXI_ARREADY,
		// Read data (issued by slave)
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// Read response. This signal indicates the status of the
    		// read transfer.
		output wire [1 : 0] S_AXI_RRESP,
		// Read valid. This signal indicates that the channel is
    		// signaling the required read data.
		output wire  S_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
		input wire  S_AXI_RREADY
	);

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 6;
	//----------------------------------------------
	//-- Signals for user logic register space example
	//------------------------------------------------
	//-- Number of Slave Registers 66
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg7;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg8;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg9;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg10;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg11;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg12;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg13;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg14;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg15;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg16;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg17;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg18;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg19;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg20;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg21;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg22;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg23;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg24;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg25;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg26;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg27;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg28;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg29;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg30;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg31;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg32;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg33;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg34;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg35;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg36;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg37;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg38;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg39;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg40;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg41;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg42;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg43;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg44;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg45;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg46;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg47;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg48;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg49;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg50;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg51;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg52;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg53;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg54;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg55;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg56;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg57;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg58;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg59;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg60;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg61;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg62;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg63;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg64;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg65;
	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 cim_data_out;
	integer	 byte_index;
	reg	 aw_en;

	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	      aw_en <= 1'b1;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // slave is ready to accept write address when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_awready <= 1'b1;
	          aw_en <= 1'b0;
	        end
	        else if (S_AXI_BREADY && axi_bvalid)
	            begin
	              aw_en <= 1'b1;
	              axi_awready <= 1'b0;
	            end
	      else           
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_awaddr latching
	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // Write Address latching 
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end 
	end       

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en )
	        begin
	          // slave is ready to accept write data when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      slv_reg0 <= 0;
	      slv_reg1 <= 0;
	      slv_reg2 <= 0;
	      slv_reg3 <= 0;
	      slv_reg4 <= 0;
	      slv_reg5 <= 0;
	      slv_reg6 <= 0;
	      slv_reg7 <= 0;
	      slv_reg8 <= 0;
	      slv_reg9 <= 0;
	      slv_reg10 <= 0;
	      slv_reg11 <= 0;
	      slv_reg12 <= 0;
	      slv_reg13 <= 0;
	      slv_reg14 <= 0;
	      slv_reg15 <= 0;
	      slv_reg16 <= 0;
	      slv_reg17 <= 0;
	      slv_reg18 <= 0;
	      slv_reg19 <= 0;
	      slv_reg20 <= 0;
	      slv_reg21 <= 0;
	      slv_reg22 <= 0;
	      slv_reg23 <= 0;
	      slv_reg24 <= 0;
	      slv_reg25 <= 0;
	      slv_reg26 <= 0;
	      slv_reg27 <= 0;
	      slv_reg28 <= 0;
	      slv_reg29 <= 0;
	      slv_reg30 <= 0;
	      slv_reg31 <= 0;
	      slv_reg32 <= 0;
	      slv_reg33 <= 0;
	      slv_reg34 <= 0;
	      slv_reg35 <= 0;
	      slv_reg36 <= 0;
	      slv_reg37 <= 0;
	      slv_reg38 <= 0;
	      slv_reg39 <= 0;
	      slv_reg40 <= 0;
	      slv_reg41 <= 0;
	      slv_reg42 <= 0;
	      slv_reg43 <= 0;
	      slv_reg44 <= 0;
	      slv_reg45 <= 0;
	      slv_reg46 <= 0;
	      slv_reg47 <= 0;
	      slv_reg48 <= 0;
	      slv_reg49 <= 0;
	      slv_reg50 <= 0;
	      slv_reg51 <= 0;
	      slv_reg52 <= 0;
	      slv_reg53 <= 0;
	      slv_reg54 <= 0;
	      slv_reg55 <= 0;
	      slv_reg56 <= 0;
	      slv_reg57 <= 0;
	      slv_reg58 <= 0;
	      slv_reg59 <= 0;
	      slv_reg60 <= 0;
	      slv_reg61 <= 0;
	      slv_reg62 <= 0;
	      slv_reg63 <= 0;
	      slv_reg64 <= 0;
	      slv_reg65 <= 0;
	    end 
	  else begin
	    if (slv_reg_wren)
	      begin
	        case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	          7'h00:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h01:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 1
	                slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h02:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 2
	                slv_reg2[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h03:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 3
	                slv_reg3[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h04:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 4
	                slv_reg4[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h05:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 5
	                slv_reg5[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h06:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 6
	                slv_reg6[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h07:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 7
	                slv_reg7[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h08:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 8
	                slv_reg8[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h09:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 9
	                slv_reg9[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h0A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 10
	                slv_reg10[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h0B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 11
	                slv_reg11[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h0C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 12
	                slv_reg12[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h0D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 13
	                slv_reg13[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h0E:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 14
	                slv_reg14[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h0F:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 15
	                slv_reg15[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h10:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 16
	                slv_reg16[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h11:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 17
	                slv_reg17[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h12:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 18
	                slv_reg18[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h13:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 19
	                slv_reg19[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h14:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 20
	                slv_reg20[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h15:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 21
	                slv_reg21[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h16:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 22
	                slv_reg22[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h17:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 23
	                slv_reg23[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h18:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 24
	                slv_reg24[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h19:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 25
	                slv_reg25[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h1A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 26
	                slv_reg26[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h1B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 27
	                slv_reg27[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h1C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 28
	                slv_reg28[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h1D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 29
	                slv_reg29[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h1E:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 30
	                slv_reg30[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h1F:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 31
	                slv_reg31[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h20:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 32
	                slv_reg32[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h21:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 33
	                slv_reg33[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h22:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 34
	                slv_reg34[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h23:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 35
	                slv_reg35[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h24:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 36
	                slv_reg36[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h25:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 37
	                slv_reg37[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h26:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 38
	                slv_reg38[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h27:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 39
	                slv_reg39[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h28:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 40
	                slv_reg40[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h29:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 41
	                slv_reg41[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h2A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 42
	                slv_reg42[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h2B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 43
	                slv_reg43[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h2C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 44
	                slv_reg44[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h2D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 45
	                slv_reg45[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h2E:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 46
	                slv_reg46[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h2F:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 47
	                slv_reg47[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h30:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 48
	                slv_reg48[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h31:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 49
	                slv_reg49[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h32:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 50
	                slv_reg50[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h33:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 51
	                slv_reg51[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h34:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 52
	                slv_reg52[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h35:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 53
	                slv_reg53[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h36:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 54
	                slv_reg54[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h37:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 55
	                slv_reg55[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h38:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 56
	                slv_reg56[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h39:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 57
	                slv_reg57[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h3A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 58
	                slv_reg58[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h3B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 59
	                slv_reg59[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h3C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 60
	                slv_reg60[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h3D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 61
	                slv_reg61[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h3E:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 62
	                slv_reg62[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h3F:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 63
	                slv_reg63[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h40:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 64
	                slv_reg64[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          7'h41:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 65
	                slv_reg65[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          default : begin
	                      slv_reg0 <= slv_reg0;
	                      slv_reg1 <= slv_reg1;
	                      slv_reg2 <= slv_reg2;
	                      slv_reg3 <= slv_reg3;
	                      slv_reg4 <= slv_reg4;
	                      slv_reg5 <= slv_reg5;
	                      slv_reg6 <= slv_reg6;
	                      slv_reg7 <= slv_reg7;
	                      slv_reg8 <= slv_reg8;
	                      slv_reg9 <= slv_reg9;
	                      slv_reg10 <= slv_reg10;
	                      slv_reg11 <= slv_reg11;
	                      slv_reg12 <= slv_reg12;
	                      slv_reg13 <= slv_reg13;
	                      slv_reg14 <= slv_reg14;
	                      slv_reg15 <= slv_reg15;
	                      slv_reg16 <= slv_reg16;
	                      slv_reg17 <= slv_reg17;
	                      slv_reg18 <= slv_reg18;
	                      slv_reg19 <= slv_reg19;
	                      slv_reg20 <= slv_reg20;
	                      slv_reg21 <= slv_reg21;
	                      slv_reg22 <= slv_reg22;
	                      slv_reg23 <= slv_reg23;
	                      slv_reg24 <= slv_reg24;
	                      slv_reg25 <= slv_reg25;
	                      slv_reg26 <= slv_reg26;
	                      slv_reg27 <= slv_reg27;
	                      slv_reg28 <= slv_reg28;
	                      slv_reg29 <= slv_reg29;
	                      slv_reg30 <= slv_reg30;
	                      slv_reg31 <= slv_reg31;
	                      slv_reg32 <= slv_reg32;
	                      slv_reg33 <= slv_reg33;
	                      slv_reg34 <= slv_reg34;
	                      slv_reg35 <= slv_reg35;
	                      slv_reg36 <= slv_reg36;
	                      slv_reg37 <= slv_reg37;
	                      slv_reg38 <= slv_reg38;
	                      slv_reg39 <= slv_reg39;
	                      slv_reg40 <= slv_reg40;
	                      slv_reg41 <= slv_reg41;
	                      slv_reg42 <= slv_reg42;
	                      slv_reg43 <= slv_reg43;
	                      slv_reg44 <= slv_reg44;
	                      slv_reg45 <= slv_reg45;
	                      slv_reg46 <= slv_reg46;
	                      slv_reg47 <= slv_reg47;
	                      slv_reg48 <= slv_reg48;
	                      slv_reg49 <= slv_reg49;
	                      slv_reg50 <= slv_reg50;
	                      slv_reg51 <= slv_reg51;
	                      slv_reg52 <= slv_reg52;
	                      slv_reg53 <= slv_reg53;
	                      slv_reg54 <= slv_reg54;
	                      slv_reg55 <= slv_reg55;
	                      slv_reg56 <= slv_reg56;
	                      slv_reg57 <= slv_reg57;
	                      slv_reg58 <= slv_reg58;
	                      slv_reg59 <= slv_reg59;
	                      slv_reg60 <= slv_reg60;
	                      slv_reg61 <= slv_reg61;
	                      slv_reg62 <= slv_reg62;
	                      slv_reg63 <= slv_reg63;
	                      slv_reg64 <= slv_reg64;
	                      slv_reg65 <= slv_reg65;
	                    end
	        endcase
	      end
	  end
	end    

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end 
	  else
	    begin    
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response 
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	            //check if bready is asserted while bvalid is high) 
	            //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	end   

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end                
	    end
	end    
	// Wires for the harness signals - Make sure they dont exceed 32 bits
	// If you exceed 32 bits use extra registers and concat in the driver code

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	// wire [C_S_AXI_DATA_WIDTH-1:0] signal_name_1
	//-- Master can only read from these registers as we are not adding the write logic to this
	//---Start here - Check the widths and split the registers - max width is 32 bits per register


	parameter integer NUM_STACKS = 8;
	parameter integer STAGE_1_NUM_INPUTS = 8;//should be power of 2
	parameter integer STAGE_1_BIT_WIDTH = 8;
	parameter integer SRAM_THROUGHPUT = 1; //cycles/bit - should be power of 2
	parameter integer STAGE_4_BIT_WIDTH = 4;
	parameter integer SIZE_ACT_ARRAY = 1;
	parameter integer STAGE_1_MAX_SHIFT_AMT = STAGE_1_NUM_INPUTS-1;
	parameter integer STAGE_1_MUX_2_NUM_INPUTS = STAGE_1_NUM_INPUTS+1;
	parameter integer STAGE_1_OUT_BIT_WIDTH = STAGE_1_BIT_WIDTH+STAGE_1_MAX_SHIFT_AMT+$clog2(STAGE_1_NUM_INPUTS);
	parameter integer STAGE_1_OUT_BIT_WIDTH_NECESSARY = STAGE_1_NUM_INPUTS + STAGE_1_BIT_WIDTH-1; //15
	parameter integer STAGE_3_OUT_BIT_WIDTH = STAGE_1_OUT_BIT_WIDTH_NECESSARY+ $clog2(STAGE_1_NUM_INPUTS); //15+3 = 18
   	parameter integer counter_bit_width = $clog2(SRAM_THROUGHPUT)+$clog2(STAGE_1_NUM_INPUTS);
   	parameter integer STAGE_4_OUT_BIT_WIDTH = STAGE_3_OUT_BIT_WIDTH+STAGE_4_BIT_WIDTH; //18+4 = 22

	wire [C_S_AXI_DATA_WIDTH-1:0] stage_4_o;
	wire [C_S_AXI_DATA_WIDTH-1:0] stage_1_in[(((NUM_STACKS*STAGE_1_NUM_INPUTS*STAGE_1_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0]; // 1
	wire [C_S_AXI_DATA_WIDTH-1:0] stage_1_flop_in[(((NUM_STACKS*STAGE_1_NUM_INPUTS*STAGE_1_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0]; // 2
	wire [C_S_AXI_DATA_WIDTH-1:0] wrData_act_q[(((NUM_STACKS*SIZE_ACT_ARRAY*STAGE_1_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0]; // 3
	wire [C_S_AXI_DATA_WIDTH-1:0] shift_out[((NUM_STACKS*STAGE_1_NUM_INPUTS*(STAGE_1_BIT_WIDTH+STAGE_1_MAX_SHIFT_AMT)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] adder_out[(((NUM_STACKS*STAGE_1_OUT_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] stage_1_out[(((NUM_STACKS*STAGE_1_OUT_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] mux_2_in[(((NUM_STACKS*STAGE_1_MUX_2_NUM_INPUTS*STAGE_1_OUT_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] sel[(((NUM_STACKS*STAGE_1_MUX_2_NUM_INPUTS)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] stage_2_in[(((NUM_STACKS*STAGE_1_OUT_BIT_WIDTH_NECESSARY)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] wrPtr_q[(((NUM_STACKS*$clog2(STAGE_1_NUM_INPUTS))+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] wrPtr_d[(((NUM_STACKS*$clog2(STAGE_1_NUM_INPUTS))+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] stage_2_out[(((NUM_STACKS*STAGE_1_NUM_INPUTS*STAGE_1_OUT_BIT_WIDTH_NECESSARY)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] stage_3_in[(((NUM_STACKS*STAGE_1_NUM_INPUTS*STAGE_1_OUT_BIT_WIDTH_NECESSARY)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] stage_3_out [(((NUM_STACKS*STAGE_3_OUT_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] stage_3_out_acc [(((NUM_STACKS*STAGE_3_OUT_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0]; 
	wire [C_S_AXI_DATA_WIDTH-1:0] stage_4_in [(((NUM_STACKS*STAGE_3_OUT_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0]; //4
	wire [C_S_AXI_DATA_WIDTH-1:0] counter_q [(((NUM_STACKS*counter_bit_width)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] counter_q1 [(((NUM_STACKS*counter_bit_width)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] counter_q2 [(((NUM_STACKS*counter_bit_width)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] counter_d [(((NUM_STACKS*counter_bit_width)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] stage_4_out_mul [(((NUM_STACKS*STAGE_4_OUT_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] stage_4_out [(((NUM_STACKS*STAGE_4_OUT_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0]; //5
	wire [C_S_AXI_DATA_WIDTH-1:0] mult_inter [(((NUM_STACKS*STAGE_4_OUT_BIT_WIDTH*STAGE_4_OUT_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0]; 
	wire [C_S_AXI_DATA_WIDTH-1:0] weight_zero [(((NUM_STACKS)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH))-1:0];
	wire [C_S_AXI_DATA_WIDTH-1:0] mul_test ;
	wire [C_S_AXI_DATA_WIDTH-1:0] done;

	//-- End here
	/*
	// References below comment after adding
		// logic [1:0] stage_4_o, //Chicken bit
		// logic [NUM_STACKS-1:0][STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH-1:0] stage_1_in,
		// logic [NUM_STACKS-1:0][STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH-1:0] stage_1_flop_in,
		// logic [NUM_STACKS-1:0][SIZE_ACT_ARRAY-1:0][STAGE_1_BIT_WIDTH-1:0] wrData_act_q,
		// logic [NUM_STACKS-1:0][STAGE_1_NUM_INPUTS-1:0][STAGE_1_BIT_WIDTH+STAGE_1_MAX_SHIFT_AMT-1:0] shift_out,
		// logic [NUM_STACKS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] adder_out,
		// logic [NUM_STACKS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] stage_1_out,
		// logic [NUM_STACKS-1:0][STAGE_1_MUX_2_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH-1:0] mux_2_in,
		// logic [NUM_STACKS-1:0][STAGE_1_MUX_2_NUM_INPUTS-1:0] sel,
		// logic [NUM_STACKS-1:0][STAGE_1_OUT_BIT_WIDTH_NECESSARY-1:0] stage_2_in,
		//  logic [NUM_STACKS-1:0][$clog2(STAGE_1_NUM_INPUTS)-1:0] wrPtr_q,
		//  logic [NUM_STACKS-1:0][$clog2(STAGE_1_NUM_INPUTS)-1:0] wrPtr_d,
		//  logic [NUM_STACKS-1:0][STAGE_1_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH_NECESSARY-1:0] stage_2_out,
		//  logic [NUM_STACKS-1:0][STAGE_1_NUM_INPUTS-1:0][STAGE_1_OUT_BIT_WIDTH_NECESSARY-1:0] stage_3_in,
		//  logic [NUM_STACKS-1:0][STAGE_3_OUT_BIT_WIDTH-1:0] stage_3_out,
		//  logic [NUM_STACKS-1:0][STAGE_3_OUT_BIT_WIDTH-1:0] stage_3_out_acc,
		//  logic [NUM_STACKS-1:0][STAGE_3_OUT_BIT_WIDTH-1:0] stage_4_in,
		//  logic [NUM_STACKS-1:0][counter_bit_width-1:0] counter_q,
		//  logic [NUM_STACKS-1:0][counter_bit_width-1:0] counter_q1,
		//  logic [NUM_STACKS-1:0][counter_bit_width-1:0] counter_q2,
		//  logic [NUM_STACKS-1:0][counter_bit_width-1:0] counter_d,
		//  logic [NUM_STACKS-1:0][STAGE_4_OUT_BIT_WIDTH-1:0] stage_4_out_mul,
		//  logic [NUM_STACKS-1:0][STAGE_4_OUT_BIT_WIDTH-1:0] stage_4_out,
		//  logic [NUM_STACKS-1:0][STAGE_4_OUT_BIT_WIDTH-1:0][STAGE_4_OUT_BIT_WIDTH-1:0] mult_inter,
		//  logic [NUM_STACKS-1:0] weight_zero, 
		//  logic [STAGE_1_BIT_WIDTH+STAGE_1_NUM_INPUTS-1:0] mul_test
		*/
	//-- Ends here
	// Add the address mapping for the harness signals below
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
//	wire [C_S_AXI_DATA_WIDTH-1:0] reg31, reg30, reg29, reg28, reg27, reg26, reg2, reg24, reg23, reg22, reg21, reg20, reg19, reg18, reg17, reg16, reg15, reg14, reg13, reg12, reg11, reg10, reg9, reg8, reg7, reg6, reg5, reg4, reg3, reg2, reg1, reg0;
	


		
		

		//genvar i;
		// parameter integer start_index_1 = 7'h42;
		// parameter integer chunk_width_1 = 1;
		// generate 
		// 	for(i=start_index_1;i<start_index_1+chunk_width_1;i+=1) begin
		// 	always @(*)
		// 	begin
		// 		if(axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]==i)	reg_data_out <= stage_4_o;
		// 	end
		// end
		// endgenerate
		
		// 7'h43 = d67
		// parameter integer start_index_2 = start_index_1 + chunk_width_1;
		// // ceil(8*8*8/32) = 16
		// parameter integer chunk_width_2 = (((NUM_STACKS*STAGE_1_NUM_INPUTS*STAGE_1_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH)); 
		// generate
		// 	for(i=start_index_2;i<start_index_2+chunk_width_2;i+=1) begin
		// 	 always@(*) begin 
		// 		if(axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]==i) reg_data_out <= stage_1_in[i-start_index_2];
		// 	 end
		// 	end
		// endgenerate

		// start = d83
		// parameter integer start_index_3 = start_index_2 + chunk_width_2;
		// // 16
		// parameter integer chunk_width_3 = (((NUM_STACKS*STAGE_1_NUM_INPUTS*STAGE_1_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH));
		// generate 
		// 	for(i=start_index_3;i<start_index_3+chunk_width_3;i+=1) begin
		// 	 always@(*) begin 
		// 		if(axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]==i) reg_data_out <= stage_1_flop_in[i-start_index_3];
		// 	 end
		// 	end 
		// endgenerate

		// // start = d99
		// parameter integer start_index_4 = start_index_3 + chunk_width_3;
		// // 8*8/32 = 2
		// parameter integer chunk_width_4 = (((NUM_STACKS*SIZE_ACT_ARRAY*STAGE_1_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH));
		// generate 
		// 	for(i=start_index_4;i<start_index_4+chunk_width_4;i+=1) begin
		// 	 always@(*) begin 
		// 		if(axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]==i) reg_data_out <= wrData_act_q[i-start_index_4];
		// 	 end
		// 	end
		// endgenerate

		// // start = d101
		// parameter integer start_index_5 = start_index_4 + chunk_width_4;
		// // ceil(8*18/32) = 5
		// parameter integer chunk_width_5 = (((NUM_STACKS*STAGE_3_OUT_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH));
		// generate
		// 	for(i=start_index_5;i<start_index_5+chunk_width_5;i+=1) begin
		// 	 always@(*) begin 
		// 		if(axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]==i) reg_data_out <= stage_4_in[i-start_index_5];
		// 	 end
		// 	end
		// endgenerate

		// // start = d106
		// parameter integer start_index_6 = start_index_5 + chunk_width_5;
		// parameter integer chunk_width_6 = (((NUM_STACKS*STAGE_4_OUT_BIT_WIDTH)+(C_S_AXI_DATA_WIDTH-1))/(C_S_AXI_DATA_WIDTH));
		// //ceil(8*22/32) = 6
		// generate
		// 	for(i=start_index_6;i<start_index_6+chunk_width_6;i+=1) begin
		// 	 always@(*) begin 
		// 		if(axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB]==i) reg_data_out <= stage_4_out[i-start_index_6];
		// 	 end
		// 	end
		// endgenerate
		// // 106+6 = 112
		always@(*) begin
		// Address decoding for reading registers
		case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
			7'h00   : reg_data_out <= slv_reg0;
			7'h01   : reg_data_out <= slv_reg1;
			7'h02   : reg_data_out <= slv_reg2;
			7'h03   : reg_data_out <= slv_reg3;
			7'h04   : reg_data_out <= slv_reg4;
			7'h05   : reg_data_out <= slv_reg5;
			7'h06   : reg_data_out <= slv_reg6;
			7'h07   : reg_data_out <= slv_reg7;
			7'h08   : reg_data_out <= slv_reg8;
			7'h09   : reg_data_out <= slv_reg9;
			7'h0A   : reg_data_out <= slv_reg10;
			7'h0B   : reg_data_out <= slv_reg11;
			7'h0C   : reg_data_out <= slv_reg12;
			7'h0D   : reg_data_out <= slv_reg13;
			7'h0E   : reg_data_out <= slv_reg14;
			7'h0F   : reg_data_out <= slv_reg15;
			7'h10   : reg_data_out <= slv_reg16;
			7'h11   : reg_data_out <= slv_reg17;
			7'h12   : reg_data_out <= slv_reg18;
			7'h13   : reg_data_out <= slv_reg19;
			7'h14   : reg_data_out <= slv_reg20;
			7'h15   : reg_data_out <= slv_reg21;
			7'h16   : reg_data_out <= slv_reg22;
			7'h17   : reg_data_out <= slv_reg23;
			7'h18   : reg_data_out <= slv_reg24;
			7'h19   : reg_data_out <= slv_reg25;
			7'h1A   : reg_data_out <= slv_reg26;
			7'h1B   : reg_data_out <= slv_reg27;
			7'h1C   : reg_data_out <= slv_reg28;
			7'h1D   : reg_data_out <= slv_reg29;
			7'h1E   : reg_data_out <= slv_reg30;
			7'h1F   : reg_data_out <= slv_reg31;
			7'h20   : reg_data_out <= slv_reg32;
			7'h21   : reg_data_out <= slv_reg33;
			7'h22   : reg_data_out <= slv_reg34;
			7'h23   : reg_data_out <= slv_reg35;
			7'h24   : reg_data_out <= slv_reg36;
			7'h25   : reg_data_out <= slv_reg37;
			7'h26   : reg_data_out <= slv_reg38;
			7'h27   : reg_data_out <= slv_reg39;
			7'h28   : reg_data_out <= slv_reg40;
			7'h29   : reg_data_out <= slv_reg41;
			7'h2A   : reg_data_out <= slv_reg42;
			7'h2B   : reg_data_out <= slv_reg43;
			7'h2C   : reg_data_out <= slv_reg44;
			7'h2D   : reg_data_out <= slv_reg45;
			7'h2E   : reg_data_out <= slv_reg46;
			7'h2F   : reg_data_out <= slv_reg47;
			7'h30   : reg_data_out <= slv_reg48;
			7'h31   : reg_data_out <= slv_reg49;
			7'h32   : reg_data_out <= slv_reg50;
			7'h33   : reg_data_out <= slv_reg51;
			7'h34   : reg_data_out <= slv_reg52;
			7'h35   : reg_data_out <= slv_reg53;
			7'h36   : reg_data_out <= slv_reg54;
			7'h37   : reg_data_out <= slv_reg55;
			7'h38   : reg_data_out <= slv_reg56;
			7'h39   : reg_data_out <= slv_reg57;
			7'h3A   : reg_data_out <= slv_reg58;
			7'h3B   : reg_data_out <= slv_reg59;
			7'h3C   : reg_data_out <= slv_reg60;
			7'h3D   : reg_data_out <= slv_reg61;
			7'h3E   : reg_data_out <= slv_reg62;
			7'h3F   : reg_data_out <= slv_reg63;
			7'h40   : reg_data_out <= slv_reg64;
			7'h41   : reg_data_out <= slv_reg65;
			7'h42   : reg_data_out <= stage_4_o;
			//16 - stage_1_in
			7'h43   : reg_data_out <= stage_1_in[0];
			7'h44   : reg_data_out <= stage_1_in[1];
			7'h45   : reg_data_out <= stage_1_in[2];
			7'h46   : reg_data_out <= stage_1_in[3];
			7'h47   : reg_data_out <= stage_1_in[4];
			7'h48   : reg_data_out <= stage_1_in[5];
			7'h49   : reg_data_out <= stage_1_in[6];
			7'h4A   : reg_data_out <= stage_1_in[7];
			7'h4B   : reg_data_out <= stage_1_in[8];
			7'h4C   : reg_data_out <= stage_1_in[9];
			7'h4D   : reg_data_out <= stage_1_in[10];
			7'h4E   : reg_data_out <= stage_1_in[11];
			7'h4F   : reg_data_out <= stage_1_in[12];
			7'h50   : reg_data_out <= stage_1_in[13];
			7'h51   : reg_data_out <= stage_1_in[14];
			7'h52   : reg_data_out <= stage_1_in[15];
			//16 - stage_1_flop_in
			7'h53   : reg_data_out <= stage_1_flop_in[0];
			7'h54   : reg_data_out <= stage_1_flop_in[1];
			7'h55   : reg_data_out <= stage_1_flop_in[2];
			7'h56   : reg_data_out <= stage_1_flop_in[3];
			7'h57   : reg_data_out <= stage_1_flop_in[4];
			7'h58   : reg_data_out <= stage_1_flop_in[5];
			7'h59   : reg_data_out <= stage_1_flop_in[6];
			7'h5A   : reg_data_out <= stage_1_flop_in[7];
			7'h5B   : reg_data_out <= stage_1_flop_in[8];
			7'h5C   : reg_data_out <= stage_1_flop_in[9];
			7'h5D   : reg_data_out <= stage_1_flop_in[10];
			7'h5E   : reg_data_out <= stage_1_flop_in[11];
			7'h5F   : reg_data_out <= stage_1_flop_in[12];
			7'h60   : reg_data_out <= stage_1_flop_in[13];
			7'h61   : reg_data_out <= stage_1_flop_in[14];
			7'h62   : reg_data_out <= stage_1_flop_in[15];
			//2 - wrData_act_q
			7'h63   : reg_data_out <= wrData_act_q[0];
			7'h64   : reg_data_out <= wrData_act_q[1];
			//5 - stage_4_in
			7'h65   : reg_data_out <= stage_4_in[0];
			7'h66   : reg_data_out <= stage_4_in[1];
			7'h67   : reg_data_out <= stage_4_in[2];
			7'h68   : reg_data_out <= stage_4_in[3];
			7'h69   : reg_data_out <= stage_4_in[4];
			//6 - stage_4_out
			7'h6A   : reg_data_out <= stage_4_out[0];
			7'h6B   : reg_data_out <= stage_4_out[1];
			7'h6C   : reg_data_out <= stage_4_out[2];
			7'h6D   : reg_data_out <= stage_4_out[3];
			7'h6E   : reg_data_out <= stage_4_out[4];
			7'h6F   : reg_data_out <= stage_4_out[5];
			7'h70 :reg_data_out <= mul_test;
			7'h71 :reg_data_out <= done;
			default : reg_data_out <= 0;
		endcase
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	  else
	    begin    
	      // When there is a valid read address (S_AXI_ARVALID) with 
	      // acceptance of read address by the slave (axi_arready), 
	      // output the read dada 
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end   
	    end
	end    

	// Add user logic here
	harness_axi harness_axi_inst(
		.clk(S_AXI_ACLK),
		//-- Input
		.wrEn_queue(slv_reg0),
		.wrData_queue(slv_reg1),
		.DISABLE_STAGE_1(slv_reg2),
		.DISABLE_STAGE_4(slv_reg3),
		.wrEn_act_array(slv_reg4),
		.wrData_act({slv_reg6,slv_reg7}), //64 bits
		.input_wt({slv_reg9,slv_reg8}),   //64 bits
		.SRAM_flop_en_in(slv_reg10),//Chicken bit
		.flop_1_en_in(slv_reg11),//Chicken bit
		.flop_3_en_in(slv_reg12),//Chicken bit
		.queue_en_in(slv_reg13),//Chicken bit for stage 2
		.wrPtr_d_in(slv_reg14), //Chicken bit --- 4 bits
		.in(slv_reg15),//Chicken bit for safety reasons
		.wrPtr_over_in(slv_reg16), //Chicken bit
		.DISABLE_STAGE_2(slv_reg17),//Chicken bit
		.DISABLE_STAGE_3(slv_reg18),//Chicken bit
		.chicken_bit(slv_reg19), //Chicken bit

		//-- Output
		.stage_4_o(stage_4_o), //Chicken bit
		.stage_1_in({stage_1_in[15],stage_1_in[14],stage_1_in[13],stage_1_in[12],stage_1_in[11],stage_1_in[10],stage_1_in[9],stage_1_in[8],stage_1_in[7],stage_1_in[6],stage_1_in[5],stage_1_in[4],stage_1_in[3],stage_1_in[2],stage_1_in[1],stage_1_in[0]}),
		.stage_1_flop_in({stage_1_flop_in[15],stage_1_flop_in[14],stage_1_flop_in[13],stage_1_flop_in[12],stage_1_flop_in[11],stage_1_flop_in[10],stage_1_flop_in[9],stage_1_flop_in[8],stage_1_flop_in[7],stage_1_flop_in[6],stage_1_flop_in[5],stage_1_flop_in[4],stage_1_flop_in[3],stage_1_flop_in[2],stage_1_flop_in[1],stage_1_flop_in[0]}),
		.wrData_act_q({wrData_act_q[1],wrData_act_q[0]}), //64 bits
		.shift_out(),
		.adder_out(),
		.stage_1_out(),
		.mux_2_in(),
		.sel(),
		.stage_2_in(),
		.wrPtr_q(),
		.wrPtr_d(),
		.stage_2_out(),
		.stage_3_in(),
		.stage_3_out(),
		.stage_3_out_acc(),
		.stage_4_in({stage_4_in[4],stage_4_in[3],stage_4_in[2],stage_4_in[1],stage_4_in[0]}), //5
		.counter_q(),
		.counter_q1(),
		.counter_q2(),
		.counter_d(),
		.stage_4_out_mul(),
		.stage_4_out({stage_4_out[5],stage_4_out[4],stage_4_out[3],stage_4_out[2],stage_4_out[1],stage_4_out[0]}), //6
		.mult_inter(),
		.weight_zero(), 
		.mul_test(mul_test),
		//-- End edits
		.reset(slv_reg64),
		.done(done)
	);

	// User logic ends

	endmodule