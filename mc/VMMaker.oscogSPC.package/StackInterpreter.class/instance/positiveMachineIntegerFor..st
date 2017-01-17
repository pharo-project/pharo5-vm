callback support
positiveMachineIntegerFor: value
	<var: #value type: #'usqIntptr_t'>
	<inline: false>
	| resultObj |
	objectMemory wordSize = 8
		ifTrue: [resultObj := self positive64BitIntegerFor: value]
		ifFalse: [resultObj := self positive32BitIntegerFor: value].
	^resultObj