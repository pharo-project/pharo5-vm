in-line cacheing
lookup: selector for: receiver methodAndErrorSelectorInto: binaryBlock
	"Lookup selector in the class of receiver.  If found, evaluate binaryBlock with the
	 method, cogged if appropriate..  If not found, due to MNU, lookup the DNU selector
	 and evaluate binaryBlock with the MNU method, cogged if appropriate..  If not found
	 due to cannot interpret, evaluate binaryBlock with a nil method and the error selector."
	| methodOrSelectorIndex |
	<inline: true>
	methodOrSelectorIndex := coInterpreter
									lookupOrdinary: selector
									receiver: receiver.
	methodOrSelectorIndex asUnsignedInteger > coInterpreter maxLookupNoMNUErrorCode ifTrue:
		[(objectMemory isOopCompiledMethod: methodOrSelectorIndex) ifFalse:
			[^binaryBlock value: methodOrSelectorIndex value: SelectorCannotInterpret].
		 ((coInterpreter methodHasCogMethod: methodOrSelectorIndex) not
		  and: [coInterpreter methodShouldBeCogged: methodOrSelectorIndex]) ifTrue:
			["We assume cog:selector: will *not* reclaim the method zone"
			 self cog: methodOrSelectorIndex selector: selector].
		^binaryBlock value: methodOrSelectorIndex value: nil].
	methodOrSelectorIndex = SelectorDoesNotUnderstand ifTrue:
		[methodOrSelectorIndex := coInterpreter
										lookupMNU: (objectMemory splObj: SelectorDoesNotUnderstand)
										receiver: receiver.
		 methodOrSelectorIndex asUnsignedInteger > coInterpreter maxLookupNoMNUErrorCode ifTrue:
			[self assert: (objectMemory isOopCompiledMethod: methodOrSelectorIndex).
			 ((coInterpreter methodHasCogMethod: methodOrSelectorIndex) not
			  and: [coInterpreter methodShouldBeCogged: methodOrSelectorIndex]) ifTrue:
				["We assume cog:selector: will *not* reclaim the method zone"
				 self cog: methodOrSelectorIndex selector: (objectMemory splObj: SelectorDoesNotUnderstand)].
			^binaryBlock value: methodOrSelectorIndex value: SelectorDoesNotUnderstand].
		^binaryBlock value: nil value: SelectorDoesNotUnderstand].
	^binaryBlock value: nil value: methodOrSelectorIndex