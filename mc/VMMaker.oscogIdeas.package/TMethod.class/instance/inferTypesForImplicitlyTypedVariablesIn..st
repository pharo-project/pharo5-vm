type inference
inferTypesForImplicitlyTypedVariablesIn: aCodeGen
	"infer types for untyped variables from assignments and arithmetic uses.
	 For debugging answer a Dictionary from var to the nodes that determined types
	 This for debugging:
		(self copy inferTypesForImplicitlyTypedVariablesIn: aCodeGen)"
	| alreadyExplicitlyTypedOrNotToBeTyped effectiveNodes |
	aCodeGen maybeBreakForTestToInline: selector in: self.
	alreadyExplicitlyTypedOrNotToBeTyped := declarations keys asSet.
	effectiveNodes := Dictionary new. "this for debugging"
	parseTree nodesDo:
		[:node| | type var |
		"If there is something of the form i >= 0, then i should be signed, not unsigned."
		(node isSend
		 and: [(locals includes: (var := node receiver variableNameOrNil))
		 and: [(alreadyExplicitlyTypedOrNotToBeTyped includes: var) not "don't be fooled by inferred unsigned types"
		 and: [(#(<= < >= >) includes: node selector)
		 and: [node args first isConstant
		 and: [node args first value = 0
		 and: [(type := self typeFor: var in: aCodeGen) notNil
		 and: [type first == $u]]]]]]]) ifTrue:
			[self declarationAt: var put: (aCodeGen signedTypeForIntegralType: type), ' ', var.
			 effectiveNodes at: var put: { declarations at: var. node }].
		"if an assignment to an untyped local of a known type, set the local's type to that type.
		 Only observe known sends (methods in the current set) and typed local variables."
		(node isAssignment
		 and: [(locals includes: (var := node variable name))
		 and: [(alreadyExplicitlyTypedOrNotToBeTyped includes: var) not]]) ifTrue: "don't be fooled by previously inferred types"
		 	[type := node expression isSend
						ifTrue: [aCodeGen returnTypeForSend: node expression in: self ifNil: nil]
						ifFalse: [self typeFor: node expression in: aCodeGen].
			 type "If untyped, then cannot type the variable yet. A subsequent assignment may assign a subtype of what this type ends up being"
				ifNil: [alreadyExplicitlyTypedOrNotToBeTyped add: var] 
				ifNotNil: "Merge simple types; complex types must be defined by the programmer."
					[(aCodeGen isSimpleType: type) ifTrue:
						[aCodeGen mergeTypeOf: var in: declarations with: type method: self.
						 effectiveNodes at: var put: { declarations at: var. node }, (effectiveNodes at: var ifAbsent: [#()])]]]].
	^effectiveNodes