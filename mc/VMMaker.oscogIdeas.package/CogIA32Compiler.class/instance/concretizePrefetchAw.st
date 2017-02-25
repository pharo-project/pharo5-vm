generate machine code
concretizePrefetchAw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| addressOperand |
	"Note that maxSize has been set to 7 or 0 in computeMaximumSize whether hasSSEInstructions or not"
	maxSize > 0 ifTrue:
		[addressOperand := operands at: 0.
		 machineCode
			at: 0 put: 16r0f;
			at: 1 put: 16r18;
			at: 2 put: (self mod: 0 RM: 5 RO: 1); "prefetch0, prefetch using the T0 temporal data hint"
			at: 3 put: (addressOperand bitAnd: 16rFF);
			at: 4 put: (addressOperand >> 8 bitAnd: 16rFF);
			at: 5 put: (addressOperand >> 16 bitAnd: 16rFF);
			at: 6 put: (addressOperand >> 24 bitAnd: 16rFF)].
	^machineCodeSize := maxSize