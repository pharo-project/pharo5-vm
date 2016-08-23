configurations
generateEitherSqueakCogVM
	| coInterpreterClass |
	coInterpreterClass := self chooseCoInterpreterClassIfAbsent: [^self].
	^self generateSqueakCogVMWithInterpreterClass: coInterpreterClass
		  options: ((coInterpreterClass includesBehavior: CoInterpreterMT)
						ifTrue: [#(COGMTVM true)]
						ifFalse: [#()])