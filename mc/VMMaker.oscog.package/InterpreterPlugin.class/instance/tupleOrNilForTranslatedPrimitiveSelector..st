simulation
tupleOrNilForTranslatedPrimitiveSelector: selector
	"Answer a tuple of {simulation method, types, subsidiary methods, original method}
	 for the selector of a translated primitive.  If the method cannot be simulated, for
	 example if it accesses instance variables, answer a tuple whose types element is nil."
	<doNotGenerate>
	^(self class methodOrNilForTranslatedPrimitiveSelector: selector) ifNotNil:
		[:method| | argNames argPragmas cg types subsidiaryMethods |
		"Since the plugin itself runs the method, and the method is on some
		 distant class, if the method accesses inst vars, the mechanism can't work."
		method hasInstVarRef ifTrue: [^{method. nil. nil. method}].
		argNames := [method methodClass newParser parseParameterNames: method getSource]
						on: Error
						do: [:ex|
							^{method. nil. nil. method}].
		argPragmas := method pragmas select:
							[:p|
							(p keyword beginsWith: 'var:')
							and: [argNames includes: p arguments first]].
		cg := translatedMethodCache at: #CCodeGenerator.
		types := (1 to: method numArgs) collect:
					[:i|
					(argPragmas detect: [:p| p arguments first = (argNames at: i)] ifNone: [])
						ifNil: [#sqInt]
						ifNotNil:
							[:pragma|
							cg extractTypeFor: (argNames at: i) fromDeclaration: pragma arguments second]].
		 "Subsidiary methods are typically implemented for the primitive method only."
		 subsidiaryMethods :=
			method messages
				select:
					[:subsidiary|
					 (method methodClass includesSelector: subsidiary)
					 and: [(Object includesSelector: subsidiary) not]]
				thenCollect:
					[:subsidiary| | subsidiaryMethod |
					subsidiaryMethod := method methodClass >> subsidiary.
					subsidiaryMethod hasInstVarRef ifTrue:
						[^{method. nil. nil. method}].
					subsidiaryMethod].
		 { self methodWithoutPrimitive: method.
		   types.
		   Dictionary withAll:
			(subsidiaryMethods collect:
				[:m| m selector -> (self methodWithoutPrimitive: m)]).
		   method}]