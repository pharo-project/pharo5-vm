testing
hasLinkRegister
	"Answer if the processor has a link register, i.e. if calls pass
	 the return pc in a register instead of pushing it on a stack."
	<inline: true>
	^self subclassResponsibility