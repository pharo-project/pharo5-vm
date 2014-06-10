compile abstract instructions
genGetDoubleValueOf: srcReg into: destFPReg 
	cogit MoveM64: BaseHeaderSize r: srcReg Rd: destFPReg.
	^0