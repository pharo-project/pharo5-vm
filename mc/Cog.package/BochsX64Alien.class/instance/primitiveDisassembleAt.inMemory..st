primitives
primitiveDisassembleAt: address inMemory: memoryArray "<Bitmap|ByteArray>"
	"Answer an Array of the size and the disassembled code string for the instruction at the current instruction pointer in memory."
	<primitive: 'primitiveDisassembleAtInMemory' module: 'BochsX64Plugin'>
	^self primitiveFailed