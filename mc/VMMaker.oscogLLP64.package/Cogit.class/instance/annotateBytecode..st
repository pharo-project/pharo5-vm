method map
annotateBytecode: abstractInstruction
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	abstractInstruction annotation: HasBytecodePC.
	^abstractInstruction