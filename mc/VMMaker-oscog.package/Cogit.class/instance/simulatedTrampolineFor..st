initialization
simulatedTrampolineFor: selectorOrAddress
	"Set a simulated trampoline.  This is a method in the cogit, coInterpreter
	 or objectMemory that is called from a machine code trampoline."
	<doNotGenerate>
	| address |
	selectorOrAddress isInteger ifTrue:
		[self assert: (simulatedTrampolines includesKey: selectorOrAddress).
		 ^selectorOrAddress].
	self assert: selectorOrAddress isSymbol.
	address := self simulatedAddressFor: selectorOrAddress.
	simulatedTrampolines at: address ifAbsentPut: [selectorOrAddress].
	^address