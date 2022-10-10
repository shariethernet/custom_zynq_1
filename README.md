# Single cycle CPU - running on FPGA
Implement all instructions for RISC-V including Branch instructions. This repository will provide the automation flow for running the design into hardware.

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

- ```PYNQ_files```       - PYNQ Overlay(bitstream related) files.

5. Open the FPGA Remote Jupyter server. Upload the ```PYNQ_files``` folder and run cpu.ipynb.
