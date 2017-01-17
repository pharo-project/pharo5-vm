initialization
setCogit: aCogit methodZone: aMethodZone
	<doNotGenerate>
	cogit := aCogit.
	methodZone := aMethodZone.
	coInterpreter := aCogit coInterpreter.
	objectMemory := (coInterpreter isKindOf: StackInterpreter)
						ifTrue: [coInterpreter objectMemory]
						ifFalse: [coInterpreter]