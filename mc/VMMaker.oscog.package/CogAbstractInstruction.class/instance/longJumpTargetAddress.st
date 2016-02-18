generate machine code
longJumpTargetAddress
	<inline: true> "Since it's an extraction from other methods."
	"This needs to be different from jumpTargetAddress because long jumps can
	be to absolute addresses and hence we can't assert that the jump target is sane."
	| jumpTarget |
	<var: #jumpTarget type: #'AbstractInstruction *'>
	jumpTarget := cogit cCoerceSimple: (operands at: 0) to: #'AbstractInstruction *'.
	(self isAnInstruction: jumpTarget) ifTrue:
		[jumpTarget := cogit cCoerceSimple: jumpTarget address to: #'AbstractInstruction *'].
	self assert: jumpTarget ~= 0.
	^jumpTarget