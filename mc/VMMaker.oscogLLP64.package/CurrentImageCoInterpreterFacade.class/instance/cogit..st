initialize-release
cogit: aCogit
	cogit := aCogit.
	cogit objectMemory ifNil:
		[cogit instVarNamed: 'objectMemory' put: objectMemory].
	coInterpreter cogit: aCogit.
	(objectMemory respondsTo: #cogit:) ifTrue:
		[objectMemory cogit: aCogit].
	(objectMemory respondsTo: #coInterpreter:) ifTrue:
		[objectMemory coInterpreter: coInterpreter].
	coInterpreter setUpForUseByFacade: self.
	objectMemory setUpForUseByFacade: self.
	#('stackLimit') do:
		[:l| self addressForLabel: l].
	self initializeObjectMap