compile abstract instructions
genGetClassObjectOf: instReg into: destReg scratchReg: scratchReg instRegIsReceiver: instRegIsReceiver
	"Fetch the instance's class into destReg.  This is almost identical
	 to genGetClassFormatOfNonInt:into:scratchReg: but because we
	 put the fetch of SmallInteger between the then and the else for 
	 compact class/non-compact class we cannot easily share code.
	 instRegIsReceiver is ignored.  It is for Spur compatibility where
	 objects may be forwarded."
	| jumpIsInt jumpCompact jumpGotClass jumpGotClass2 |
	<var: #jumpIsInt type: #'AbstractInstruction *'>
	<var: #jumpCompact type: #'AbstractInstruction *'>
	<var: #jumpGotClass type: #'AbstractInstruction *'>
	<var: #jumpGotClass2 type: #'AbstractInstruction *'>
	cogit MoveR: instReg R: scratchReg.
	cogit AndCq: 1 R: scratchReg.
	jumpIsInt := cogit JumpNonZero: 0.
	"Get header word in scratchReg"
	cogit MoveMw: 0 r: instReg R: scratchReg.
	"Form the byte index of the compact class field"
	cogit LogicalShiftRightCq: (objectMemory compactClassFieldLSB - objectMemory shiftForWord) R: scratchReg.
	cogit AndCq: self compactClassFieldMask << objectMemory shiftForWord R: scratchReg.
	jumpCompact := cogit JumpNonZero: 0.
	cogit MoveMw: objectMemory classFieldOffset r: instReg R: destReg.
	cogit AndCq: AllButTypeMask signedIntFromLong R: destReg.
	jumpGotClass := cogit Jump: 0.
	jumpIsInt jmpTarget: (cogit genMoveConstant: objectMemory classSmallInteger R: destReg).
	jumpGotClass2 := cogit Jump: 0.
	"Don't have to subtract one from the destReg compactClassArray index because of the header word."
	self assert: objectMemory baseHeaderSize = objectMemory wordSize.
	jumpCompact jmpTarget:
		(cogit annotate: (cogit MoveMw: (objectMemory splObj: CompactClasses) r: scratchReg R: destReg)
			objRef: (objectMemory splObj: CompactClasses)).
	jumpGotClass jmpTarget:
	(jumpGotClass2 jmpTarget: cogit Label).
	^0