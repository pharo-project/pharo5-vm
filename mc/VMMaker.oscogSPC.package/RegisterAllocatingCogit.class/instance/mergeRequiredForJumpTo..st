bytecode generator support
mergeRequiredForJumpTo: targetPC
	"While this is a multi-pass compiler, no intermediate control-flow graph is built from bytecode and
	 there is a monotonically increasing one-to-one relationship between bytecode pcs and machine
	 code pcs that map to one another.  Therefore, when jumping forward, any required code to merge
	 the state of the current simStack with that at the target must be generated before the jump
	 (because at the target the simStack state will be whatever falls through). If only one forward jump
	 to the target exists then that jump can simply install its simStack as the required simStack at the
	 target and the merge code wil be generated just before the target as control falls through.  But if
	 there are two or more forward jumps to the target, a situation that occurs given that the
	 StackToRegisterMappingCogit follows jump chains, then jumps other than the first must generate
	 merge code before jumping.  This poses a problem for conditional branches.  The merge code must
	 only be generated along the path that takes the jump  Therefore this must *not* be generated:

			... merge code ...
			jump cond Ltarget

	 which incorrectly executes the merge code along both the taken and untaken paths.  Instead
	 this must be generated so that the merge code is only executed if the branch is taken.

			jump not cond Lcontinue
			... merge code ...
			jump Ltarget
		Lcontinue:

	 Note that no merge code is required for code such as self at: (expr ifTrue: [1] ifFalse: [2])
		17 <70> self
		18 <71> pushConstant: true
		19 <99> jumpFalse: 22
		20 <76> pushConstant: 1
		21 <90> jumpTo: 23
		22 <77> pushConstant: 2
		23 <C0> send: at:
	 provided that 1 and 2 are assigned to the same target register."
	| fixup |
	(fixup := self fixupAt: targetPC) hasMergeSimStack ifFalse:
		[^false].
	self assert: simStackPtr = fixup simStackPtr.
	^self mergeRequiredToTarget: fixup mergeSimStack