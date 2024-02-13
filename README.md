# A Co-processor for Fully Homomorphic Encryption Execution (CoFHEE)

CoFHEE is the first silicon-proven hardware accelerator for low-level polynomial operations targeting Fully Homomorphic Encryption (FHE) execution. It features implementations of fundamental polynomial operations, including polynomial addition and subtraction, Hadamard product, and Number Theoretic Transform (NTT), which underlie most higher-level FHE primitives. The current version of CoFHEE can natively support polynomial degrees of up to $N = 2^{13}$ with a coefficient size of 128 bits and has been fabricated and silicon-verified using 55nm CMOS technology.

## Highlights :
* Max modulus size: 128-bit.
* Polynomial Degrees supported: 8192, 4096, 2048, 1024, 512,256, 128
* =~ (N/2)logN cycles for NTT operation.
* 53535 cycles for 8192 polynomial degree => .27 ms in 55nm when clocked at 200 Mhz with an area of 15mm2.
* Duplicate the hardware for better performance.
* Can be used as an On-Chip or Off-chip co-processor/Hardware accelerator.
* Uart and SPI interface to interface with an external host.
* Uses AHB interconnect => Easy to plugin to existing SoC
* Command FIFO to enable a sequence of micro-operations.
* ARM Cortex M0 to control and sequence the operation if needed.
* DMA for the data movement.
* Operations supported : 
  * NTT/iNTT            
  * Pointwise Modular multiplication/addition/subtraction of vectors.
  * Scalar/Constant vector multiplication of polynomial coefficients. Needed for Inverse-NTT. 
  * Pointwise Normal multiplication of vectors.
  * Modular vector squaring.


## CoFHEE Bus Architecture
Below is the top-level bus architecture diagram of CoFHEE.
![image](https://github.com/momalab/CoFHEE/assets/18638799/f7bfb337-30a6-4ab2-8510-6a3a71424ed8)

Please note that the RTL files for CortexM0 are not included in the repo because of NDA restrictions. 

## Repo Details
This repo contains RTL files, verification setup, and synthesis setup for CoFHEE. The top-level file is 

[./modules/ccs0302/rtl/ccs0302.v](https://github.com/momalab/CoFHEE/blob/main/modules/ccs0302/rtl/ccs0302.v).

To find all the file dependencies, refer to

[./modules/ccs0302/verif/run_test.sh](https://github.com/momalab/CoFHEE/blob/main/modules/ccs0302/verif/run_test.sh)

This is also the top-level verification script and uses Synopsys VCS for simulation. The run command for simulation is:

./run_test.sh -test <testcase name in [./modules/ccs0302/verif/testcases](https://github.com/momalab/CoFHEE/blob/main/modules/ccs0302/verif/testcases) directory>

Ex: `./run_test.sh -test ntt.v`

The top-level synthesis script using Synopsys DC is at [./modules/ccs0302/synth/run_synth.tcl](https://github.com/momalab/CoFHEE/blob/main/modules/ccs0302/synth/run_synth.tcl). The run command for synthesis is:

`dc_shell-t -no_gui -64bit -x "source -echo -verbose ./run_synth.tcl" -output_log_file ./synth.log`

# Request for a CoFHEE chip
A limited number of fabricated ASICs of CoFHEE and Python APIs to communicate to it from an external host can be sent to researchers. Please [e-mail the MoMA Lab director](mailto:michail.maniatakos+cophee@nyu.edu) with a request.

## License
You can use our RTL files under the [MIT license](https://www.mit.edu/~amini/LICENSE.md). 

## Cite us!
If you wish to acknowledge or reference our work, please use the below citations:

Nabeel, Mohammed, et al. "CoFHEE: A co-processor for fully homomorphic encryption execution." 2023 Design, Automation & Test in Europe Conference & Exhibition (DATE). IEEE, 2023.

M. Nabeel et al., "Silicon-proven ASIC Design for the Polynomial Operations of Fully Homomorphic Encryption," in IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems, doi: 10.1109/TCAD.2024.3359526.


 
