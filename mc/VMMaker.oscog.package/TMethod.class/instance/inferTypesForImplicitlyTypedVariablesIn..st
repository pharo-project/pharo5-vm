type inference
inferTypesForImplicitlyTypedVariablesIn: aCodeGen
	"infer types for untyped variables from assignments and arithmetic uses.
	 For debugging answer a Dictionary from var to the nodes that determined types
	 This for debugging:
		(self copy inferTypesForImplicitlyTypedVariablesIn: aCodeGen)"
	| alreadyExplicitlyTypedOrNotToBeTyped asYetUntyped mustBeSigned newDeclarations effectiveNodes |
	aCodeGen maybeBreakForTestToInline: selector in: self.
	alreadyExplicitlyTypedOrNotToBeTyped := declarations keys asSet.
	asYetUntyped := locals copyWithoutAll: alreadyExplicitlyTypedOrNotToBeTyped.
	mustBeSigned := Set new.
	newDeclarations := Dictionary new.
	effectiveNodes := Dictionary new. "this for debugging"
	parseTree nodesDo:
		[:node| | type var |
		"If there is something of the form i >= 0, then i should be signed, not unsigned."
		(node isSend
		 and: [(locals includes: (var := node receiver variableNameOrNil))
		 and: [(#(<= < >= >) includes: node selector)
		 and: [node args first isConstant
		 and: [node args first value = 0]]]]) ifTrue:
			[mustBeSigned add: var.
			 effectiveNodes at: var put: { #signed. node }, (effectiveNodes at: var ifAbsent: [#()])].
		"if an assignment to an untyped local of a known type, set the local's type to that type.
		 Only observe known sends (methods in the current set) and typed local variables."
		(node isAssignment
		 and: [(locals includes: (var := node variable name))
		 and: [(alreadyExplicitlyTypedOrNotToBeTyped includes: var) not]]) ifTrue: "don't be fooled by previously inferred types"
		 	[type := node expression isSend
						ifTrue: [aCodeGen returnTypeForSend: node expression in: self ifNil: nil]
						ifFalse: [self typeFor: (node expression isAssignment
													ifTrue: [node expression variable]
													ifFalse: [node expression]) in: aCodeGen].
			 type "If untyped, then cannot type the variable yet. A subsequent assignment may assign a subtype of what this type ends up being"
				ifNil: "Further, if the type derives from an as-yet-untyped method, we must defer."
					[alreadyExplicitlyTypedOrNotToBeTyped add: var.
					 (node expression isSend
					 and: [(aCodeGen methodNamed: node expression selector) notNil]) ifTrue:
						[newDeclarations removeKey: var ifAbsent: nil]]
				ifNotNil: "Merge simple types (but *don't* merge untyped vars); complex types must be defined by the programmer."
					[(aCodeGen isSimpleType: type) ifTrue:
						[(asYetUntyped includes: var)
							ifTrue: [newDeclarations at: var put: type, ' ', var. asYetUntyped remove: var]
							ifFalse:
								[aCodeGen mergeTypeOf: var in: newDeclarations with: type method: self].
						 effectiveNodes at: var put: { newDeclarations at: var. node }, (effectiveNodes at: var ifAbsent: [#()])]]]].
	mustBeSigned do:
		[:var|
		 (newDeclarations at: var ifAbsent: nil) ifNotNil:
			[:decl| | type |
			 type := aCodeGen extractTypeFor: var fromDeclaration: decl.
			 type first == $u ifTrue:
				[newDeclarations at: var put: (aCodeGen signedTypeForIntegralType: type), ' ', var]]].
	newDeclarations keysAndValuesDo:
		[:var :decl| declarations at: var put: decl].
	^effectiveNodes