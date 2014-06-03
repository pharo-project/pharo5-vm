initialization
setCogit: aCogit methodZone: aMethodZone
	<doNotGenerate>
	cogit := aCogit.
	methodZone := aMethodZone.
	objectMemory := (aCogit coInterpreter isKindOf: StackInterpreter)
						ifTrue: [aCogit coInterpreter objectMemory]
						ifFalse: [aCogit coInterpreter]