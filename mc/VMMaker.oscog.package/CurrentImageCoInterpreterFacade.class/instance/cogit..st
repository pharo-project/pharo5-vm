initialize-release
cogit: aCogit
	cogit := aCogit.
	coInterpreter cogit: aCogit.
	(objectMemory respondsTo: #cogit:) ifTrue:
		[objectMemory cogit: aCogit]