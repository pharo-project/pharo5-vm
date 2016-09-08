compile abstract instructions
genGetInlineCacheClassTagFrom: sourceReg into: destReg forEntry: forEntry
	"Extract the inline cache tag for the object in sourceReg into destReg. The inline
	 cache tag for a given object is the value loaded in inline caches to distinguish
	 objects of different classes.  In Spur this is either the tags for immediates, or
	 the receiver's classIndex.  Answer the label for the start of the sequence."
	| jumpImm entryLabel |
	<var: #jumpImm type: #'AbstractInstruction *'>
	<var: #entryLabel type: #'AbstractInstruction *'>
	forEntry ifTrue:
		[cogit AlignmentNops: objectMemory wordSize].
	entryLabel := cogit Label.
	cogit AndCq: objectMemory tagMask R: sourceReg R: destReg.
	jumpImm := cogit JumpNonZero: 0.
	"Get least significant half of header word in destReg"
	self flag: #endianness.
	cogit MoveMw: 0 r: sourceReg R: destReg.
	cogit AndCq: objectMemory classIndexMask R: destReg.
	jumpImm jmpTarget: cogit Label.
	^entryLabel