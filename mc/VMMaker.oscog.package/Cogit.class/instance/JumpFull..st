abstract instructions
JumpFull: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: JumpFull literal: jumpTarget asInteger