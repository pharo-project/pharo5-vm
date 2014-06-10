compile abstract instructions
getInlineCacheClassTagFrom: sourceReg into: destReg
	"Extract the inline cache tag for the object in sourceReg into destReg. The inline
	 cache tag for a given object is the value loaded in inline caches to distinguish objects
	 of different classes.  In SqueakV3 the tag is the integer tag bit for SmallIntegers (1),
	 the compact class index shifted by log: 2 word size for objects with compact classes
	 (1 * 4 to: 31 * 4 by: 4), or the class.  These ranges cannot overlap because the heap
	 (and hence the lowest class object) is beyond the machine code zone."
	| entryLabel jumpIsInt jumpCompact |
	<var: #entryLabel type: #'AbstractInstruction *'>
	<var: #jumpIsInt type: #'AbstractInstruction *'>
	<var: #jumpCompact type: #'AbstractInstruction *'>
	cogit AlignmentNops: (BytesPerWord max: 8).
	entryLabel := cogit Label.
	cogit MoveR: sourceReg R: destReg.
	cogit AndCq: 1 R: destReg.
	jumpIsInt := cogit JumpNonZero: 0.
	"Get header word in destReg"
	cogit MoveMw: 0 r: sourceReg R: destReg.
	"Form the byte index of the compact class field"
	cogit LogicalShiftRightCq: (objectMemory compactClassFieldLSB - ShiftForWord) R: destReg.
	cogit AndCq: self compactClassFieldMask << ShiftForWord R: destReg.
	jumpCompact := cogit JumpNonZero: 0.
	cogit MoveMw: objectMemory classFieldOffset r: sourceReg R: destReg.
	"The use of signedIntFromLong is a hack to get round short addressing mode computations.
	 Much easier if offsets are signed and the arithmetic machinery we have makes it difficult to
	 mix signed and unsigned offsets."
	cogit AndCq: AllButTypeMask signedIntFromLong R: destReg.
	jumpCompact jmpTarget: (jumpIsInt jmpTarget: cogit Label).
	^entryLabel