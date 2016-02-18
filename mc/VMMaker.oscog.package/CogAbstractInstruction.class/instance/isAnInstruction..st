testing
isAnInstruction: addressOrInstruction
	<var: #addressOrInstruction type: #'AbstractInstruction *'>
	<inline: true>
	^(cogit addressIsInInstructions: addressOrInstruction)
	  or: [addressOrInstruction == cogit methodLabel]