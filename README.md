# Numerical MATLAB experiments with multi-term adders
This repository contains the MATLAB source code for reproducing the results in [Sec. 4, 1] and [Sec. 5, 1].
   
The scripts rely on the [CPFloat](https://github.com/north-numerical-computing/cpfloat) library for implementing custom-precision arithmetics and therefore it should be downloaded and placed on the MATLAB search path. These experiments were developed and run on MATLAB version 2022b_beta on the Apple M1 Pro.

### References

 [1] M. Mikaitis. [*Monotonicity of Multi-Term Floating-Point Adders*](https://arxiv.org/abs/2304.01407).	arXiv:2304.01407 [cs.MS]. Apr. 2023.

### License

This software is distributed under the terms of the 2-clause BSD software license (see [LICENSE](./LICENSE)).

The CPFloat C library is distributed under the [GNU Lesser General Public License, Version 2.1 or later](https://raw.githubusercontent.com/mfasi/cpfloat/master/LICENSES/LGPL-2.1-or-later.txt).