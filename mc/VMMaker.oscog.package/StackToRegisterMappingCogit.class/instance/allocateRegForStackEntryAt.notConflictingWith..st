simulation stack
allocateRegForStackEntryAt: index notConflictingWith: regMask
	"If the stack entry is already in a register not conflicting with regMask, answers it,
	else allocate a new register not conflicting with reg mask"
	<var: #stackEntry type: #'CogSimStackEntry *'>
	| stackEntry mask |
	stackEntry := self ssValue: index.
	mask := stackEntry registerMaskOrNone.
	(mask ~= 0 and: [mask noMask: regMask]) ifTrue: 
		[self flag: #TODO.
		"When one does pushDup on a SSRegister
		 followed by an operation reusing the register 
		 but mutating the value of the register, then the value that was 
		 dup is now refering to the register with a mutated value which
		 is incorrect. This problem is serious as it can happen also with 
		 multiple unsafe instructions (no dup involved)
		 This is not a problem if the operation reusing the register is not 
		 mutating the value of if all the dup values are used in the same 
		 operation.
		 => I think we should introduce allocateRegMutatingStackEntryAt:
		notConflictingWith:upThrough:, used by operations mutating the reg
		value and flushing partially the stack if somewhere between simSpill
		and the ssEntries used by the operation someone uses also the same
		register."
		 ^stackEntry registerOrNone].
	^self allocateRegNotConflictingWith: regMask