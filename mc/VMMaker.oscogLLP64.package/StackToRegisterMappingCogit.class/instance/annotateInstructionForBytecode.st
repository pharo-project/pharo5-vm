bytecode generator support
annotateInstructionForBytecode
	"Annotate the current instruction as having a bytecode pc.  If the current instruction
	 is already annotated, insert a nop and annotate that.  We cannot have the same instruction
	 address carry multiple annotations."
	<inline: true>
	self annotateBytecode: (self prevInstIsPCAnnotated
								ifTrue: [self Nop]
								ifFalse: [self Label]).