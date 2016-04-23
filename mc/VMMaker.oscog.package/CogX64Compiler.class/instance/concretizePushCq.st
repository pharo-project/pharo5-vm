generate machine code
concretizePushCq
	<inline: true>
	| value |
	value := operands at: 0.
	(self isQuick: value) ifTrue:
		[machineCode
			at: 0 put: 16r6A;
			at: 1 put: (value bitAnd: 16rFF).
		^machineCodeSize := 2].
	(self is32BitSignedImmediate: value) ifTrue:
		[machineCode
			at: 0 put: 16r68;
			at: 1 put: (value bitAnd: 16rFF);
			at: 2 put: (value >> 8 bitAnd: 16rFF);
			at: 3 put: (value >> 16 bitAnd: 16rFF);
			at: 4 put: (value >> 24 bitAnd: 16rFF).
		^machineCodeSize := 5].
	^self concretizePushCw