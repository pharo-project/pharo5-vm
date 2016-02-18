utilities
typeFor: aVariable in: aCodeGen
	"Answer the type for aVariable, deferring to aCodeGen (which defers to the vmClass)
	 if no type is found and the variable is global (not an arg or a local).  Expect the
	 cCodeGen to answer nil for variables without types. nil for typelessness is required
	 by the type propagation logic in inlineSend:directReturn:exitVar:in:."
	| varName |
	varName := aVariable asString.
	^(declarations
			at: varName
			ifAbsent:
				[(args includes: varName) "arg types default to sqInt"
					ifTrue: ['sqInt ', varName]
					ifFalse:
						[(locals includes: varName) ifFalse: "don't provide type for locals"
							[aCodeGen typeOfVariable: varName]]]) ifNotNil:
		[:decl|
		aCodeGen extractTypeFor: varName fromDeclaration: decl]