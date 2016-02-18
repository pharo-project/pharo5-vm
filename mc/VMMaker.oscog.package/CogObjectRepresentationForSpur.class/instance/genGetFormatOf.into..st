compile abstract instructions
genGetFormatOf: srcReg into: destReg
	"Get the format field of the object in srcReg into destReg.
	 srcReg may equal destReg."
	^self genGetBits: objectMemory formatMask ofFormatByteOf: srcReg into: destReg