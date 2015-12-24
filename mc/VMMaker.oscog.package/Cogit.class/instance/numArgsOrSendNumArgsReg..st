initialization
numArgsOrSendNumArgsReg: numArgs
	"The send trampolines have different versions for different arg counts, with special
	 cases for 0 through NumSendTrampolines - 2, and a general case for more, passing
	 the arg count in SendNumArgsReg.  This computes the relevant argument."
	<inline: true>
	^numArgs <= (NumSendTrampolines - 2)
		ifTrue: [self trampolineArgConstant: numArgs]
		ifFalse: [SendNumArgsReg]