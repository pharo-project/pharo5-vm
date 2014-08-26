initialize-release
cogit: aCogit
	cogit := aCogit.
	coInterpreter cogit: aCogit.
	(objectMemory respondsTo: #cogit:) ifTrue:
		[objectMemory cogit: aCogit].
	(objectMemory respondsTo: #coInterpreter:) ifTrue:
		[objectMemory coInterpreter: coInterpreter]