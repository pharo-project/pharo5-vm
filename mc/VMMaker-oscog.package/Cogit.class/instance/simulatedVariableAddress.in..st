initialization
simulatedVariableAddress: getter in: receiver
	"Answer a simulated variable.  This is a variable whose value can be read
	 by generated machine code."
	<doNotGenerate>
	| address |
	address := self simulatedAddressFor: getter.
	simulatedVariableGetters
		at: address
		ifAbsentPut: [MessageSend receiver: receiver selector: getter].
	^address