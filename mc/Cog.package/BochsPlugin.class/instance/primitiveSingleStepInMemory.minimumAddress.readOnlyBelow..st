primitives
"cpuAlien <BochsIA32|X86Alien>" primitiveSingleStepInMemory: memory "<Bitmap|ByteArray|WordArray>" minimumAddress: minAddress "<Integer>"  readOnlyBelow: minWriteMaxExecAddress "<Integer>"
	"Single-step the cpu using the first argument as the memory and the following arguments defining valid addresses."
	| cpuAlien cpu maybeErr |
	<var: #cpu type: #'void *'>
	cpuAlien := self primitive: #primitiveSingleStepInMemoryMinimumAddressReadWrite
					parameters: #(WordsOrBytes Unsigned Unsigned)
					receiver: #Oop.
	(cpu := self cCoerceSimple: (self startOfData: cpuAlien) to: #'void *') = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	maybeErr := self singleStepCPU: cpu
					In: memory
					Size: (interpreterProxy byteSizeOf: memory cPtrAsOop)
					MinAddressRead: minAddress
					Write: minWriteMaxExecAddress.
	maybeErr ~= 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrInappropriate].
	^cpuAlien