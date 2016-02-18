type inference
inferTypesForImplicitlyTypedVariablesIn: aCodeGen
	"infer types for untyped variables from assignments and arithmetic uses.
	 For debugging answer a Dictionary from var to the nodes that determined types
	 This for debugging:
		(self copy inferTypesForImplicitlyTypedVariablesIn: aCodeGen)"
	| alreadyExplicitlyTyped effectiveNodes |
	aCodeGen maybeBreakForTestToInline: selector in: self.
	alreadyExplicitlyTyped := declarations keys asSet.
	effectiveNodes := Dictionary new. "this for debugging"
	parseTree nodesDo:
		[:node| | type var |
		"If there is something of the form i >= 0, then i should be signed, not unsigned."
		(node isSend
		 and: [(locals includes: (var := node receiver variableNameOrNil))
		 and: [(alreadyExplicitlyTyped includes: var) not "don't be fooled by inferred unsigned types"
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
		 and: [(alreadyExplicitlyTyped includes: var) not "don't be fooled by previously inferred types"
		 and: [(type := node expression isSend
						ifTrue: [aCodeGen returnTypeOrNilForSend: node expression in: self]
						ifFalse: [self typeFor: node expression in: aCodeGen]) notNil
		 and: [aCodeGen isSimpleType: type]]]]) ifTrue:
			[aCodeGen mergeTypeOf: var in: declarations with: type method: self.
			 effectiveNodes at: var put: { declarations at: var. node }, (effectiveNodes at: var ifAbsent: [#()])]].
	^effectiveNodes