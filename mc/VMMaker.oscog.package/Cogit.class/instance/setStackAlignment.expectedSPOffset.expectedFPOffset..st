initialization
setStackAlignment: stackAlignment expectedSPOffset: spOffset expectedFPOffset: fpOffset
	"the processor wants certain stack alignment settings"
	expectedSPAlignment := spOffset. 
	expectedFPAlignment := fpOffset. 
	cStackAlignment := stackAlignment
