CoFHEE is the first silicon-proven co-processor for low-level polynomial operations targeting Fully Homomorphic Encryption (FHE) execution. It features implementations of fundamental polynomial operations, including polynomial addition and subtraction, Hadamard product, and Number Theoretic Transform (NTT), which underlie most higher-level FHE primitives. The current version of CoFHEE can natively support polynomial degrees of up to $n = 2^{14}$ with a coefficient size of 128 bits and has been fabricated and silicon-verified using 55nm CMOS technology.

This repo contains RTL files, verification setup, and synthesis setup for CoFHEE. The top-level file is 
./modules/ccs0302/rtl/ccs0302.v.

To find all the file dependencies, refer to
./modules/ccs0302/verif/run_test.sh 

This is also the top-level verification script and uses Synopsys VCS for simulation. The run command for simulation is:
./run_test.sh -test <testcase name in ./modules/ccs0302/verif/testcases directory>
Ex: ./run_test.sh -test ntt.v

The top-level synthesis script using Synopsys DC is at ./modules/ccs0302/synth/run_synth.tcl.

Below is the top-level bus architecture diagram of CoFHEE.
![image](https://github.com/momalab/CoFHEE/assets/18638799/f7bfb337-30a6-4ab2-8510-6a3a71424ed8)

Please note that the RTL files for CortexM0 are not included in the repo because of NDA restrictions. 

You can use our RTL files under the MIT license. If you wish to acknowledge or reference our work, please use the below citation:

M. Nabeel et al., "Silicon-proven ASIC Design for the Polynomial Operations of Fully Homomorphic Encryption," in IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems, doi: 10.1109/TCAD.2024.3359526.


 
