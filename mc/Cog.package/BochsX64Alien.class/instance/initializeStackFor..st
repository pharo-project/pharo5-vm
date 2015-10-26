processor setup
initializeStackFor: aCogit
	"Different cpus need different stack alignment etc, so handle the details here."
	"From the System V ABI:
	 3.2.2 The Stack Frame
	 ...	The end of the input argument area shall be aligned on a 16 (32, if __m256 is
		passed on stack) byte boundary. In other words, the value (%rsp + 8) is always
		a multiple of 16 (32) when control is transferred to the function entry point."
	aCogit setStackAlignment: 16 expectedSPOffset: 0 expectedFPOffset: 0