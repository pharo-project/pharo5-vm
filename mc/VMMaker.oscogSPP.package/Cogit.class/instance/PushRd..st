abstract instructions
PushRd: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^ backEnd genPushRd: reg