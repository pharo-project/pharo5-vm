compile abstract instructions
genGetNumSlotsOf: srcReg into: destReg
	"Get the size in word-sized slots of the object in srcReg into destReg.
	 srcReg may equal destReg."
	self subclassResponsibility