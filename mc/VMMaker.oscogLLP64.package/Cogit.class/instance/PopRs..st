abstract instructions
PopRs: reg
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^ backEnd genPopRs: reg