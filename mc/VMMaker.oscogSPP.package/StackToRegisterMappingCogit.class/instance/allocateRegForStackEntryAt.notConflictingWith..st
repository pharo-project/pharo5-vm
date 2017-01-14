simulation stack
allocateRegForStackEntryAt: index notConflictingWith: regMask
	"If the stack entry is already in a register not conflicting with regMask, answers it,
	else allocate a new register not conflicting with reg mask"
	<var: #stackEntry type: #'CogSimStackEntry *'>
	| stackEntry mask |
	stackEntry := self ssValue: index.
	mask := stackEntry registerMaskOrNone.
	(mask ~= 0 and: [mask noMask: regMask]) ifTrue: 
		[^stackEntry registerOrNone].
	^self allocateRegNotConflictingWith: regMask