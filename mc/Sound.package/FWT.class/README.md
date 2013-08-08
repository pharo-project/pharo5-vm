This class implements the Fast Wavelet Transform.  It follows Mac Cody's article in Dr. Dobb's Journal, April 1992.  See also... 
	http://www.dfw.net/~mcody/fwt/fwt.html

Notable features of his implementation include...
1.  The ability to generate a large family of wavelets (including the Haar (alpha=beta) and Daubechies) from two parameters, alpha and beta, which range between -pi and pi.
2.  All data arrays have 5 elements added on to allow for convolution overrun with filters up to 6 in length (the max for this implementation).
3.  After a forward transform, the detail coefficients of the deomposition are found in transform at: 2*i, for i = 1, 2, ... nLevels;  and the approximation coefficients are in transform at: (2*nLevels-1).  these together comprise the complete wavelet transform.

The following changes from cody's listings should also be noted...
1.  The three DotProduct routines have been merged into one.
2.  The four routines WaveletDecomposition, DecomposeBranches, WaveletReconstruction, ReconstructBranches have all been merged into transformForward:.
3.  All indexing follows the Smalltalk 1-to-N convention, naturally.