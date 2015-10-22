initialization
setStackAlignment: stackAlignment expectedSPOffset: spOffset expectedFPOffset: fpOffset
	"the processor wants certain stack alignment settings"
	self assert: stackAlignment isPowerOfTwo.
	expectedSPAlignment := spOffset. 
	expectedFPAlignment := fpOffset. 
	cStackAlignment := stackAlignment
