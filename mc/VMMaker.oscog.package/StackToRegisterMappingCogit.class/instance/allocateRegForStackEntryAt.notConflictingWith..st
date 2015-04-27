simulation stack
allocateRegForStackEntryAt: index notConflictingWith: regMask
	<var: #stackEntry type: #'CogSimStackEntry *'>
	| stackEntry |
	stackEntry := self ssValue: index.
	(stackEntry type = SSRegister and: [ (self register: stackEntry register isInMask: regMask) not ]) ifTrue: 
		[ ^ stackEntry register].
	^ self allocateRegNotConflictingWith: regMask
	