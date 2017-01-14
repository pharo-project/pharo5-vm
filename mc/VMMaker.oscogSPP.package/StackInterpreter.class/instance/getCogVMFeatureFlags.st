internal interpreter access
getCogVMFeatureFlags
	"Answer an array of flags indicating various optional features of the Cog VM.
	 Bit 0: supports two btecode sets (MULTIPLEBYTECODESETS)
	 Bit 1: supports immtablity (IMMUTABILITY)"
	^objectMemory integerObjectOf: (MULTIPLEBYTECODESETS ifTrue: [1] ifFalse: [0])
									+ (IMMUTABILITY ifTrue: [2] ifFalse: [0])