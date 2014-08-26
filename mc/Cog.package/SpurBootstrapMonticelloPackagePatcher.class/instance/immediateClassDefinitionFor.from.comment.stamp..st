private-accessing
immediateClassDefinitionFor: className from: definitions comment: commentString stamp: stampString
	| classDef |
	classDef := definitions detect: [:d| d isClassDefinition and: [d className = className]].
	classDef variables removeAllSuchThat:
		[:varDef|
		 varDef isInstanceVariable and: [varDef name = 'value']].
	classDef
		instVarNamed: 'type' put: #immediate;
		instVarNamed: 'comment' put: commentString;
		instVarNamed: 'commentStamp' put: stampString.
	^MCAddition of: classDef