private
disassembleInstructionAt: index In: inst into: binaryBlock
	"Manage the fact that in the simulator inst machineCode object is an Array and the disassembler requires a ByteArray or some such."
	^self processor
		disassembleInstructionAt: index
		In: (self memoryAsBytes: inst machineCode object)
		into: binaryBlock