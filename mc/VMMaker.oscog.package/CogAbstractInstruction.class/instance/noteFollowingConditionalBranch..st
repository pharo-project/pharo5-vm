abstract instructions
noteFollowingConditionalBranch: branch
	"Support for processors without condition codes, such as the MIPS.
	 Answer the branch opcode.  If there are no condition codes, modify
	 the receiver and the branch to implement a suitable conditional
	 branch that doesn't depend on condition codes being set by the
	 receiver.  By default a noop. Overridden in subclasses as required."
	<returnTypeC: #'AbstractInstruction *'>
	<var: #branch type: #'AbstractInstruction *'>
	<inline: true>
	^branch