utilities
typeFor: aVariable in: aCodeGen
	"Answer the type for aVariable, deferring to aCodeGen (which defers to the vmClass)
	 if no type is found and the variable is global (not an arg or a local).  Expect the
	 cCodeGen to answer nil for variables without types. nil for typelessness is required
	 by the type propagation logic in inlineSend:directReturn:exitVar:in:."
	^(declarations
			at: aVariable asString
			ifAbsent: [((locals includes: aVariable) or: [args includes: aVariable]) ifFalse:
						[aCodeGen typeOfVariable: aVariable]]) ifNotNil:
		[:decl|
		aCodeGen extractTypeFor: aVariable fromDeclaration: decl]