primitives
primitiveRunInMemory: memoryArray "<Bitmap|ByteArray>" minimumAddress: minimumAddress "<Integer>" readOnlyBelow: minimumWritableAddress "<Integer>"
	"Run the receiver using the argument as the store.  Origin the argument at 0. i.e. the first byte of the
	 memoryArray is address 0.  Make addresses below minimumAddress illegal.  Convert out-of-range
	 calls, jumps and memory read/writes into ProcessorSimulationTrap signals."
	<primitive: 'primitiveRunInMemoryMinimumAddressReadWrite' module: 'BochsX64Plugin' error: ec>
	^ec == #'inappropriate operation'
		ifTrue: [self handleExecutionPrimitiveFailureIn: memoryArray
					minimumAddress: minimumAddress]
		ifFalse: [self reportPrimitiveFailure]

	"self printRegistersOn: Transcript"