primitive generators
genGetFormatOf: srcReg into: destReg
	"Get the format field of the object in srcReg into destReg.
	 srcReg may equal destReg."
	<inline: true>
	cogit
		MoveMw: 0 r: srcReg R: destReg;
		LogicalShiftRightCq: objectMemory instFormatFieldLSB R: destReg;
		AndCq: self instFormatFieldMask R: destReg.
	^0