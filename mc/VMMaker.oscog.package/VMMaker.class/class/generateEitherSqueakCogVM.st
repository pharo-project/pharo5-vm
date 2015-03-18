configurations
generateEitherSqueakCogVM
	| coInterpreterClass |
	coInterpreterClass := self chooseCoInterpreterClassIfAbsent: [^self].
	^self generateSqueakCogVMWithInterpreterClass: coInterpreterClass
		  options: #( ISA IA32),
					((coInterpreterClass includesBehavior: CoInterpreterMT)
						ifTrue: [#(COGMTVM true)]
						ifFalse: [#()])