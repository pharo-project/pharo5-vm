profiling primitives
positiveMachineIntegerFor: value
	<var: #value type: #'unsigned long'>
	<inline: true>
	^objectMemory wordSize = 8
		ifTrue: [coInterpreter positive64BitIntegerFor: value]
		ifFalse: [coInterpreter positive32BitIntegerFor: value]