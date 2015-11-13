private
memoryAsBytes: instructionMachineCode
	"Answer an AbstractInstruction's machine code as a ByteArray.  Subclasses that represent instruction
	 data using Array should override to convert appropriately."
	instructionMachineCode isCObjectAccessor ifTrue:
		[^self memoryAsBytes: instructionMachineCode object].
	self assert: instructionMachineCode class isBits.
	^instructionMachineCode