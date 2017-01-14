accessing
checkedDeclarationAt: aVariableName put: aDeclaration in: aCCodeGen
	((args includes: aVariableName)
	 or: [(locals includes: aVariableName)
	 or: [(definingClass instVarIndexFor: aVariableName asString ifAbsent: nil) notNil]]) ifFalse:
		[| msg |
		 msg := definingClass name, '>>', selector, ' contains declaration for non-existent variable ', aVariableName.
		 aCCodeGen
			ifNotNil: [aCCodeGen logger show: msg; cr]
			ifNil: [self error: msg]].
	^self declarationAt: aVariableName  "<String>" put: aDeclaration