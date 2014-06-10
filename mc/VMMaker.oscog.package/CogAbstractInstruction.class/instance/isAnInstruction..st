testing
isAnInstruction: addressOrInstruction
	<var: #addressOrInstruction type: #'AbstractInstruction *'>
	^cogit addressIsInInstructions: addressOrInstruction