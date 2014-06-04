method map
annotateBytecode: abstractInstruction
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	^self annotate: abstractInstruction with: HasBytecodePC