abstract instructions
PushRs: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^ backEnd genPushRs: reg