compile abstract instructions
genGetNumBytesOf: srcReg into: destReg
	"Get the size in byte-sized slots of the object in srcReg into destReg.
	 srcReg may equal destReg.
	 destReg <- numSlots << self shiftForWord - (fmt bitAnd: 3).
	 Assumes the object in srcReg has a byte format, i.e. 16 to 23 or 24 to 31 "
	self subclassResponsibility