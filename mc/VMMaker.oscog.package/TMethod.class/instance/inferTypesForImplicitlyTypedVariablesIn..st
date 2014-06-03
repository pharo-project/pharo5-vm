type inference
inferTypesForImplicitlyTypedVariablesIn: aCodeGen
	"infer types for untyped variables form assignments and arithmetic uses.
	 This for debugging:
		(self copy inferTypesForImplicitlyTypedVariablesIn: aCodeGen)"
	| explicitlyTyped effectiveNodes |
	explicitlyTyped := declarations keys asSet.
	effectiveNodes := Dictionary new. "this for debugging"
	parseTree nodesDo:
		[:node| | type var |
		"If there is something of the form i >= 0, then i should be signed, not unsigned."
		(node isSend
		 and: [(locals includes: (var := node receiver variableNameOrNil))
		 and: [(explicitlyTyped includes: var) not
		 and: [(#(<= < >= >) includes: node selector)
		 and: [node args first isConstant
		 and: [node args first value = 0
		 and: [(type := self typeFor: var in: aCodeGen) notNil
		 and: [type first == $u]]]]]]]) ifTrue:
			[declarations at: var put: (declarations at: var) allButFirst.
			 effectiveNodes at: var put: { declarations at: var. node }].
		"if an assignment of a known send, set the variable's type to the return type of the send."
		(node isAssignment
		 and: [(locals includes: (var := node variable name))
		 and: [(declarations includesKey: var) not
		 and: [node expression isSend
		 and: [(type := aCodeGen returnTypeForSend: node expression) notNil]]]]) ifTrue:
			[(#(sqInt void) includes: type) ifFalse:
				["the $: is to map things like unsigned field : 3 to usqInt"
				 declarations
					at: var
					put: ((type includes: $:) ifTrue: [#usqInt] ifFalse: [type]), ' ', var.
				 effectiveNodes at: var put: { declarations at: var. node }]]].
	^effectiveNodes