The Wavelet codec performs a wavelet transform on the original data.  It then achieves its compression by thresholding the transformed data, converting all values below a given magnitude to zero, and then run-coding the resulting data.  The run-coding provides automatic variable compression depending on the parameters chosen.

As is, this codec achieves reasonable reproduction at 10:1 compression, although the quality from the GSMCodec is definitely better.  I feel that the quality would be comparable if uLaw scaling were introduced prior to thresholding.

The nice thing about using wavelets is there are numerous factors to play with for better performance:
	nLevels - the "order" of the transform performed
	alpha and beta - these specify the wavelet shape (some are better for speech)
	the actual threshold used
By simply changing these parameters, one can easily vary the compression achieved from 5:1 to 50:1, and listen to the quality at each step.

The specific format for an encoded buffer is as follows:
	4 bytes: frameCount.
	4 bytes: samplesPerFrame.
	4 bytes: nLevels.
	4 bytes: alpha asIEEE32BitWord.
	4 bytes: beta asIEEE32BitWord.
	frameCount occurrences of...
		2 bytes: frameSize in bytes, not including these 2
			may be = 0 for complete silence, meaning no scale even.
		4 bytes: scale asIEEE32BitWord.
		A series of 1- or 2-byte values encoded as follows:
			0-111: 	a run of N+1 consecutive 0's;
			112-127:	a run of (N-112)*256 + nextByte + 1 consecutive 0's;
			128-255:	a 15-bit signed value = (N*256 + nextByte) - 32768 - 16384.