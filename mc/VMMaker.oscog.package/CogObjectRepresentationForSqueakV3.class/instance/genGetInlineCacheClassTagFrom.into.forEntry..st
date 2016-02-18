compile abstract instructions
genGetInlineCacheClassTagFrom: sourceReg into: destReg forEntry: forEntry
	"Extract the inline cache tag for the object in sourceReg into destReg. The inline cache tag
	 for a given object is the value loaded in inline caches to distinguish objects of different
	 classes.  In Spur this is either the tags for immediates, or the receiver's classIndex.
	 The inline cache tag for a given object is the value loaded in inline caches to distinguish
	 objects of different classes.  In SqueakV3 the tag is the integer tag bit for SmallIntegers (1),
	 the compact class index shifted by log: 2 word size for objects with compact classes
	 (1 * 4 to: 31 * 4 by: 4), or the class.  These ranges cannot overlap because the heap
	 (and hence the lowest class object) is beyond the machine code zone.
	 If forEntry is true answer the entry label at which control is to enter (cmEntryOffset).
	 If forEntry is false, control enters at the start."
	| entryLabel jumpIsInt jumpCompact |
	<var: #entryLabel type: #'AbstractInstruction *'>
	<var: #jumpIsInt type: #'AbstractInstruction *'>
	<var: #jumpCompact type: #'AbstractInstruction *'>
	cogit AlignmentNops: (objectMemory wordSize max: 8).
	entryLabel := cogit Label.
	cogit MoveR: sourceReg R: destReg.
	cogit AndCq: 1 R: destReg.
	jumpIsInt := cogit JumpNonZero: 0.
	"Get header word in destReg"
	cogit MoveMw: 0 r: sourceReg R: destReg.
	"Extract the compact class field, and if non-zero use it as the tag.."
	self assert: self compactClassFieldMask << objectMemory compactClassFieldLSB < objectMemory nilObject asUnsignedInteger.
	cogit AndCq: self compactClassFieldMask << objectMemory compactClassFieldLSB R: destReg.
	jumpCompact := cogit JumpNonZero: 0.
	cogit MoveMw: objectMemory classFieldOffset r: sourceReg R: destReg.
	"The use of signedIntFromLong is a hack to get round short addressing mode computations.
	 Much easier if offsets are signed and the arithmetic machinery we have makes it difficult to
	 mix signed and unsigned offsets."
	cogit AndCq: AllButTypeMask signedIntFromLong R: destReg.
	jumpCompact jmpTarget: (jumpIsInt jmpTarget: cogit Label).
	^entryLabel