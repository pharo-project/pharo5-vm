primitives
"cpuAlien <BochsIA32|X86Alien>" primitiveRunInMemory: memory "<Bitmap|ByteArray|WordArray>" minimumAddress: minAddress "<Integer>" readOnlyBelow: minWriteMaxExecAddress "<Integer>"
	"Run the cpu using the first argument as the memory and the following arguments defining valid addresses, running until it halts or hits an exception."
	| cpuAlien cpu maybeErr |
	<var: #cpu type: #'void *'>
	cpuAlien := self primitive: #primitiveRunInMemoryMinimumAddressReadWrite
					parameters: #(WordsOrBytes Unsigned Unsigned)
					receiver: #Oop.
	(cpu := self cCoerceSimple: (self startOfData: cpuAlien) to: #'void *') = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	prevInterruptCheckChain := interpreterProxy setInterruptCheckChain: #forceStopOnInterrupt asSymbol.
	prevInterruptCheckChain = #forceStopOnInterrupt asSymbol ifTrue:
		[prevInterruptCheckChain = 0].
	maybeErr := self runCPU: cpu
					In: memory
					Size: (interpreterProxy byteSizeOf: memory cPtrAsOop)
					MinAddressRead: minAddress
					Write: minWriteMaxExecAddress.
	interpreterProxy setInterruptCheckChain: prevInterruptCheckChain.
	maybeErr ~= 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrInappropriate].
	^cpuAlien