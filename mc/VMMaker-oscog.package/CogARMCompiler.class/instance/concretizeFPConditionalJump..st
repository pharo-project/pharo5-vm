generate machine code - concretize
concretizeFPConditionalJump: conditionCode
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| offset |
	self assert: (operands at: 0) ~= 0.
	offset := ((operands at: 0) - (address + 8)) signedIntFromLong "signed-conversion for range assertion".
	self assert: offset <= 33554428 & (offset >= -33554432).
	self machineCodeAt: 0 put: 16rEF1FA10. "FMSTAT: copy the FPSCR to CPSR"
	self machineCodeAt: 4 put: (self c: conditionCode t: 5 o: 0 s: 0) + (offset >> 2 bitAnd: 16r00FFFFFF). "B offset"
	^machineCodeSize := 8