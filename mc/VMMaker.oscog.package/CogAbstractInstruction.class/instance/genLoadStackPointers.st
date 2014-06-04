smalltalk calling convention
genLoadStackPointers
	"Switch back to the Smalltalk stack. Assign SPReg first
	 because typically it is used immediately afterwards."
	self subclassResponsibility