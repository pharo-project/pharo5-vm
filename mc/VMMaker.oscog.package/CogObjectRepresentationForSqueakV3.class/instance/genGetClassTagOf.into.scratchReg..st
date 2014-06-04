compile abstract instructions
genGetClassTagOf: instReg into: destReg scratchReg: scratchReg
	"Compatibility with SpurObjectRepresentation/SpurMemoryManager."
	| entryLabel |
	<var: #entryLabel type: #'AbstractInstruction *'>
	cogit AlignmentNops: (BytesPerWord max: 8).
	entryLabel := cogit Label.
	self genGetClassObjectOf: instReg into: destReg scratchReg: scratchReg instRegIsReceiver: nil.
	^entryLabel