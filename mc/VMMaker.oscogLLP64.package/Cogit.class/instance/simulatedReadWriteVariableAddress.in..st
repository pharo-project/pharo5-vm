initialization
simulatedReadWriteVariableAddress: getter in: receiver
	"Answer a simulated variable.  This is a variable whose value can be read
	 and written by generated machine code."
	<doNotGenerate>
	| address |
	address := self simulatedVariableAddress: getter in: receiver.
	simulatedVariableSetters
		at: address
		ifAbsentPut:
			[| setter |
			setter := (((getter beginsWith: 'get')
						ifTrue: ['s', getter allButFirst]
						ifFalse: [getter]), ':') asSymbol.
			[:value| receiver perform: setter with: value]].
	^address