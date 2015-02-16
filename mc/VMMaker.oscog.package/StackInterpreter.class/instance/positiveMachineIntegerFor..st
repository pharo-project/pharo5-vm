callback support
positiveMachineIntegerFor: value
	<var: #value type: #'unsigned long'>
	<inline: true>
	^objectMemory wordSize = 8
		ifTrue: [self positive64BitIntegerFor: value]
		ifFalse: [self positive32BitIntegerFor: value]