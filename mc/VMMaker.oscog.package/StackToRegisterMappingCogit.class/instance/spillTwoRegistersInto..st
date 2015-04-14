simulation stack
spillTwoRegistersInto: binaryBlock
	"Any occurrences on the stack of the register must be
	 flushed, and hence any values colder than them stack."
	<var: #desc type: #'CogSimStackEntry *'>
	| r1 r2 index |
	index := simSpillBase max: 0.
	[r1 notNil and: [r2 notNil and: [index < simStackPtr]]] whileTrue:
		[| desc |
		 desc := self simStackAt: index.
		 desc type = SSRegister ifTrue:
			[ r1
				ifNil: [r1 := desc register]
				ifNotNil: [r1 ~= desc register ifTrue:
							[r2 := desc register]]].
		 index := index + 1].
	self assert: (r1 notNil and: [r2 notNil]).
	self ssAllocateRequiredReg: r1 and: r2.
	^binaryBlock value: r1 value: r2