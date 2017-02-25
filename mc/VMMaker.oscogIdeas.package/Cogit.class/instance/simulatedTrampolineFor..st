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
	simulatedTrampolines
		at: address
		ifAbsentPut:
			[MessageSend
				receiver: ((self respondsTo: selectorOrAddress)
							ifTrue: [self]
							ifFalse: [(coInterpreter respondsTo: selectorOrAddress)
										ifTrue: [coInterpreter]
										ifFalse: [(objectMemory respondsTo: selectorOrAddress)
											ifTrue: [objectMemory]
											ifFalse: [(backEnd respondsTo: selectorOrAddress)
												ifTrue:[backEnd]
												ifFalse:[self notify: 'cannot find receiver for ', selectorOrAddress]]]])
				selector: selectorOrAddress
				arguments: (1 to: selectorOrAddress numArgs) asArray].
	^address