generate machine code
assertValidAnnotation: annotation for: instruction
	"Insist that the IsObjectReference applies only to out-of-line literals."
	<var: #instruction type: #'AbstractInstruction *'>
	<inline: true>
	self assert: (annotation ~= cogit getIsObjectReference or: [instruction opcode = Literal])