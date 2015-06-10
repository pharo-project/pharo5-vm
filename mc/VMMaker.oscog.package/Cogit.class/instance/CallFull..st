abstract instructions
CallFull: jumpTarget
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: CallFull literal: jumpTarget