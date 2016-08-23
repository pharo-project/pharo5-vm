callback support
positiveMachineIntegerFor: value
	<var: #value type: #'usqIntptr_t'>
	<inline: true>
	^objectMemory wordSize = 8
		ifTrue: [self positive64BitIntegerFor: value]
		ifFalse: [self positive32BitIntegerFor: value]