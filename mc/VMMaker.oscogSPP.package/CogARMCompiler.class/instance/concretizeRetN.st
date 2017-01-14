generate machine code - concretize
concretizeRetN
	"Will get inlined into concretizeAt: switch."
	<var: #offset type: #sqInt>
	<inline: true>
	| offset |
	offset := operands at: 0.
	offset = 0 ifTrue:
		[self machineCodeAt: 0 put: (self mov: PC rn: LR). "pop	{pc}"
		^machineCodeSize := 4].
	self assert: offset < 255. "We have an 8 bit immediate. If needed, we could rotate it less than 30 bit."

	self machineCodeAt: 0 put: (self add: SP rn: SP imm: offset  ror: 0).
	self machineCodeAt: 4 put: (self mov: PC rn: LR).  "pop	{pc}"
	^machineCodeSize := 8