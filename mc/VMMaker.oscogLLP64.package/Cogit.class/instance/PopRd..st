abstract instructions
PopRd: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^ backEnd genPopRd: reg