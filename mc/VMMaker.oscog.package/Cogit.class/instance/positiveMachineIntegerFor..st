profiling primitives
positiveMachineIntegerFor: value
	<var: #value type: #'usqIntptr_t'>
	<inline: true>
	^objectMemory wordSize = 8
		ifTrue: [coInterpreter positive64BitIntegerFor: value]
		ifFalse: [coInterpreter positive32BitIntegerFor: value]