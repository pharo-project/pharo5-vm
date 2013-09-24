configurations
generateSqueakCogSistaVM
	^VMMaker
		generate: CoInterpreter
		and: SistaStackToRegisterMappingCogit
		to: (FileDirectory default pathFromURI: 'oscogvm/sistasrc')
		platformDir: (FileDirectory default pathFromURI: 'oscogvm/platforms')
		excluding: (InterpreterPlugin withAllSubclasses collect: [:ea| ea name])