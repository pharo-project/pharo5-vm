*MethodMassage-debugging
indexOfDifferenceWith: method
	"Answer whether the receiver implements the same code as the argument, method.
	 Here ``same code'' means that if the receiver's source is compiled with the same
	 compiler it should produce the same sequence of bytecodes and literals, same
	 trailer and same properties.  Hence this definition of #= (only one of many plausible
	 definitions) can be used to quickly identify changes in the compiler's output."
	| numLits |
	method isCompiledMethod ifFalse: [^1].
	self size = method size ifFalse: [^-2].
	self header = method header ifFalse: [^-3]. "N.B. includes numLiterals comparison."
	self initialPC to: self endPC do:
		[:i | (self at: i) = (method at: i) ifFalse: [^i]].
	numLits := self numLiterals.
	1 to: numLits do:
		[:i| | lit1 lit2 |
		lit1 := self literalAt: i.
		lit2 := method literalAt: i.
		(lit1 == lit2 or: [lit1 literalEqual: lit2]) ifFalse:
			[(i = 1 and: [#(117 120) includes: self primitive])
				ifTrue:
					[lit1 isArray
						ifTrue:
							[(lit2 isArray and: [lit1 allButLast = lit2 allButLast]) ifFalse:
								[^i]]
						ifFalse: "ExternalLibraryFunction"
							[(lit1 analogousCodeTo: lit2) ifFalse:
								[^i]]]
				ifFalse:
					[i = (numLits - 1)
						ifTrue: "properties"
							[(self properties analogousCodeTo: method properties)
								ifFalse: [^i]]
						ifFalse: "last literal (methodClassAssociation) of class-side methods is not unique"
							[(i = numLits
							 and: [lit1 isVariableBinding
							 and: [lit2 isVariableBinding
							 and: [lit1 key == lit2 key
							 and: [lit1 value == lit2 value]]]]) ifFalse:
								[^i]]]]].
	^0