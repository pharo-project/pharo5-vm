type inference
addTypesFor: node to: typeSet in: aCodeGen
	"Add the value types for the node to typeSet.
	 Answer if any type was derived from an as-yet-untyped method, which allows us to abort
	 inferReturnTypeFromReturnsIn: if the return type depends on a yet-to-be-typed method."
	| expr |
	expr := node.
	[expr isAssignment or: [expr isStmtList]] whileTrue:
		[expr isAssignment ifTrue:
			[expr := expr variable].
		 expr isStmtList ifTrue:
			[expr := expr statements last]].
	expr isSend ifTrue:
		[(#(ifTrue: ifFalse: ifTrue:ifFalse: ifFalse:ifTrue:) includes: expr selector) ifTrue:
			[^expr args
				inject: false
				into: [:asYetUntyped :block|
					asYetUntyped | (self addTypesFor: block to: typeSet in: aCodeGen)]].
		(aCodeGen returnTypeForSend: expr in: self ifNil: nil)
			ifNil: [^(aCodeGen methodNamed: expr selector) notNil and: [expr selector ~~ selector]]
			ifNotNil:
				[:type |
				typeSet add: type.
				^false].].
	expr isVariable ifTrue:
		[(aCodeGen typeOfVariable: expr name)
			ifNotNil: [:type| typeSet add: type]
			ifNil: [typeSet add: (expr name = 'self'
										ifTrue: [#void]
										ifFalse: [#sqInt])]].
	expr isConstant ifTrue:
		[(expr typeOrNilFrom: aCodeGen in: self) ifNotNil:
			[:type | typeSet add: type]]..
	^false