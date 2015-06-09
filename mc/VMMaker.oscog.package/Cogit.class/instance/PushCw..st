abstract instructions
PushCw: wordConstant
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self gen: PushCw literal: wordConstant