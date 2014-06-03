primitives
"cpuAlien <GdbARMAlien>" primitiveSingleStepInMemory: memory "<Bitmap|ByteArray|WordArray>" minimumAddress: minAddress "<Integer>" maximumAddress: maxAddress "<Integer>" readOnlyBelow: minWriteMaxExecAddress "<Integer>"
	"Single-step the cpu using the first argument as the memory and the following arguments defining valid addresses, running until it halts or hits an exception."
	| cpuAlien cpu memorySize maybeErr |
	<var: #cpu type: #'void *'>
	cpuAlien := self primitive: #primitiveSingleStepInMemoryMinAddressMaxAddressReadWrite
					parameters: #(WordsOrBytes Unsigned Unsigned Unsigned)
					receiver: #Oop.
	(cpu := self startOfData: cpuAlien) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	prevInterruptCheckChain := interpreterProxy setInterruptCheckChain: #forceStopOnInterrupt asSymbol.
	prevInterruptCheckChain = #forceStopOnInterrupt asSymbol ifTrue:
		[prevInterruptCheckChain = 0].
	memorySize := interpreterProxy byteSizeOf: memory cPtrAsOop.
	maybeErr := self singleStepCPU: cpu
					In: memory
					Size: (memorySize min: maxAddress)
					MinAddressRead: minAddress
					Write: minWriteMaxExecAddress.
	interpreterProxy setInterruptCheckChain: prevInterruptCheckChain.
	maybeErr ~= 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrInappropriate].
	^cpuAlien