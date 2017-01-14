abstract instructions
PushCq: wordConstant
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: PushCq quickConstant: wordConstant