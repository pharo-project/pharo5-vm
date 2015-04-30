simulation stack
allocateRegForStackEntryAt: index notConflictingWith: regMask
	"If the stack entry is already in a register not conflicting with regMask, answers it,
	else allocate a new register not conflicting with reg mask"
	<var: #stackEntry type: #'CogSimStackEntry *'>
	| stackEntry |
	stackEntry := self ssValue: index.
	(stackEntry type = SSRegister and: [ (self register: stackEntry register isInMask: regMask) not ]) ifTrue: 
		[ ^ stackEntry register].
	^ self allocateRegNotConflictingWith: regMask
	