compile abstract instructions
genGetDoubleValueOf: srcReg into: destFPReg 
	cogit MoveM64: objectMemory baseHeaderSize r: srcReg Rd: destFPReg.
	^0