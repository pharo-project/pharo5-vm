private-accessing
immediateClassDefinitionFor: className from: definitions
	| classDef |
	classDef := definitions detect: [:d| d isClassDefinition and: [d className = className]].
	classDef variables removeAllSuchThat:
		[:varDef|
		 varDef isInstanceVariable and: [varDef name = 'value']].
	classDef instVarNamed: 'type' put: #immediate.
	^MCAddition of: classDef