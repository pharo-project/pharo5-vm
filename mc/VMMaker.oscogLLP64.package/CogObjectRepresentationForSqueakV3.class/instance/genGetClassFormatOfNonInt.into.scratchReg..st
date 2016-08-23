compile abstract instructions
genGetClassFormatOfNonInt: instReg into: destReg scratchReg: scratchReg
	"Fetch the instance's class format into destReg, assuming the object is non-int."
	| jumpCompact jumpGotClass |
	<var: #jumpCompact type: #'AbstractInstruction *'>
	<var: #jumpGotClass type: #'AbstractInstruction *'>
	"Get header word in destReg"
	cogit MoveMw: 0 r: instReg R: destReg.
	"Form the byte index of the compact class field"
	cogit LogicalShiftRightCq: (objectMemory compactClassFieldLSB - objectMemory shiftForWord) R: destReg.
	cogit AndCq: self compactClassFieldMask << objectMemory shiftForWord R: destReg.
	jumpCompact := cogit JumpNonZero: 0.
	cogit MoveMw: objectMemory classFieldOffset r: instReg R: scratchReg.
	"The use of signedIntFromLong is a hack to get round short addressing mode computations.
	 Much easier if offsets are signed and the arithmetic machinery we have makes it difficult to
	 mix signed and unsigned offsets."
	cogit AndCq: AllButTypeMask signedIntFromLong R: scratchReg.
	jumpGotClass := cogit Jump: 0.
	"Don't have to subtract one from the destReg compactClassArray index because of the header word."
	self assert: objectMemory baseHeaderSize = objectMemory wordSize.
	jumpCompact jmpTarget:
		(cogit annotate: (cogit MoveMw: (objectMemory splObj: CompactClasses) r: destReg R: scratchReg)
			objRef: (objectMemory splObj: CompactClasses)).
	jumpGotClass jmpTarget:
		(cogit MoveMw: InstanceSpecificationIndex << objectMemory shiftForWord + objectMemory wordSize r: scratchReg R: destReg).
	^0