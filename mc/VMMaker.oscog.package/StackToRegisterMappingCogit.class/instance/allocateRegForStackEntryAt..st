simulation stack
allocateRegForStackEntryAt: index
	<inline: true>
	<var: #stackEntry type: #'CogSimStackEntry *'>
	| stackEntry |
	stackEntry := self ssValue: index.
	stackEntry type = SSRegister ifTrue: [ ^ stackEntry register].
	^ self allocateAnyReg
	