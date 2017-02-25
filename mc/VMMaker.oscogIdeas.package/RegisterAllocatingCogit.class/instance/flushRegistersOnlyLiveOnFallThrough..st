simulation stack
flushRegistersOnlyLiveOnFallThrough: fixup
	"Forward jumps won't generate merge code if the source has a register that is live but the destination does not.
	 For example in
			| v | v := expr1. self expr2 ifTrue: [v := expr3]. ^v
	 v will be assigned to a register in v := expr1 and [v := expr3], but the send of expr2 will flush it along the jumpFalse across [v := expr3].
	 So v will not be in a register if reached from the jump.  Hence at the join at the end of [v := expr3] v must be marked as not being in a register."
	| targetSimStack |
	targetSimStack := fixup mergeSimStack.
	0 to: simStackPtr do:
		[:i| | fallThrough target |
		 fallThrough := self simStack: simStack at: i.
		 target := self simStack: targetSimStack at: i.
		 self assert: (fallThrough liveRegister = target liveRegister or: [target liveRegister = NoReg or: [fallThrough liveRegister = NoReg]]).
		 target liveRegister = NoReg ifTrue:
			[fallThrough liveRegister: NoReg]]