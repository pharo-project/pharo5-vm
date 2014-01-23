configurations
generateSqueakCogSistaVM
	^ VMMaker
		generate:
			(Smalltalk
				at:
					([ :choices | choices at: (UIManager default chooseFrom: choices) ifAbsent: [ ^ self ] ]
						value: #(#CoInterpreter #CoInterpreterMT)))
		and: SistaStackToRegisterMappingCogit
		to: 'oscogvm/sistasrc' asFileReference fullName
		platformDir: 'oscogvm/platforms' asFileReference fullName
		excluding: (InterpreterPlugin withAllSubclasses collect: [ :ea | ea name ])