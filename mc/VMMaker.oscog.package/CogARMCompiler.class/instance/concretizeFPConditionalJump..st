generate machine code - concretize
concretizeFPConditionalJump: conditionCode
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| offset |
	self assert: (operands at: 0) ~= 0.
	offset := ((operands at: 0) - (address + 8)) signedIntFromLong "signed-conversion for range assertion".
	self assert: offset <= 33554428 & (offset >= -33554432).
	self machineCodeAt: 0 put: self fmstat. "FMSTAT: copy the FPSCR to CPSR"
	self machineCodeAt: 4 put: (self cond: conditionCode br: 0 offset: offset). "B offset"
	^machineCodeSize := 8