inlining
initializerForInstVar: varName in: aClass
	| instVarIndex |
	instVarIndex := aClass instVarIndexFor: varName ifAbsent: [^nil].
	aClass selectorsAndMethodsDo:
		[:s :m| | tmeth |
		((s beginsWith: 'initialize')
		 and: [m writesField: instVarIndex]) ifTrue:
			[tmeth := m methodNode asTranslationMethodOfClass: TMethod.
			 tmeth parseTree nodesDo:
				[:node| | exprOrAssignment |
				(node isAssignment
				 and: [node variable name = varName]) ifTrue:
					[exprOrAssignment := node.
					 [exprOrAssignment isAssignment] whileTrue:
						[exprOrAssignment := exprOrAssignment expression].
					 ^exprOrAssignment]]]].
	^nil