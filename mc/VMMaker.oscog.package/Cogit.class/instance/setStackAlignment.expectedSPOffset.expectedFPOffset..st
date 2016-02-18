initialization
setStackAlignment: stackAlignment expectedSPOffset: spOffset expectedFPOffset: fpOffset
	"Spcific platform ABIs mandate specific stack frame alignments.  We capture
	 these constraints in the variables here and test they are adhered to via
	 assertCStackWellAligned whenever transitioning to code that will run in C."
	self assert: stackAlignment isPowerOfTwo.
	expectedSPAlignment := spOffset \\ stackAlignment.
	expectedFPAlignment := fpOffset \\ stackAlignment.
	cStackAlignment := stackAlignment
