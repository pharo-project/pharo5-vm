initialization
setCogit: aCogit
	<doNotGenerate>
	cogit := aCogit.
	objectMemory := (aCogit coInterpreter isKindOf: ObjectMemory)
						ifTrue: [aCogit coInterpreter]
						ifFalse: [aCogit coInterpreter objectMemory]