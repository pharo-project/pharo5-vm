bytecode generators
annotateBytecodeIfAnnotated: aSimStackEntry
	<var: #aSimStackEntry type: #'CogSimStackEntry *'>
	<inline: false>
	aSimStackEntry annotateUse ifTrue:
		[self annotateBytecode: (self prevInstIsPCAnnotated
									ifTrue: [self Nop]
									ifFalse: [self Label]).
		 aSimStackEntry annotateUse: false]