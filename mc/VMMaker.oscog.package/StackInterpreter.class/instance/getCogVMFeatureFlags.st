internal interpreter access
getCogVMFeatureFlags
	"Answer an array of flags indicating various optional features of the Cog VM.
	 Bit 0: supports two bytecode sets (MULTIPLEBYTECODESETS)
	 Bit 1: supports immutablity (IMMUTABILITY)
	 Bit 2: suffers from a UNIX setitimer signal-based heartbeat"
	^objectMemory integerObjectOf: (MULTIPLEBYTECODESETS ifTrue: [1] ifFalse: [0])
									+ (IMMUTABILITY ifTrue: [2] ifFalse: [0])
									+ (self cppIf: #'ITIMER_HEARTBEAT' ifTrue: [4] ifFalse: [0])