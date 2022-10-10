# Single cycle CPU - running on FPGA
Implement all instructions for RISC-V including Branch instructions. This repository will provide the automation flow for running the design into hardware.

## Changes to make in cpu.v file:
One extra output port ```registers``` is added in the ```cpu.v``` file. This should store all 32 register values in the order reg31,reg30,...,reg1,reg0(you can use concatenation operator). Add logic for the same in the code.

## Steps to run:
1. Clone this repository:
```
git clone https://gitlab.com/BalaDhinesh/cpu_fpga
cd cpu_fpga
```

2. Update ```cpu.v``` and add all verilog module files which needs to be instantiated inside it. Update the list inside ```program_file.txt```.
3. Run the python file. This will take care of creating a block design on Vivado and generate bitstream.
```
python harness.py
```
4. Once the bitstream has been generated successfully, following outputs are generated.

- ```harness_axi_ip```   - IP generation. Leave this for now.

- ```harness_axi_proj``` - Vivado project file. 

- ```PYNQ_cpu.tar```       - PYNQ Overlay(bitstream related) files.

5. Open the FPGA Remote Jupyter server. 
- Upload the ```PYNQ_cpu.tar``` tar folder 
- Open terminal in server and untar using 
```
cd /home/xilinx/jupyter_notebooks
tar -xvf PYNQ_cpu.tar
```
- Now run the ```cpu.ipynb``` file.
