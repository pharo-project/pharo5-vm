type inference
addTypesFor: node to: typeSet in: aCodeGen
	"Add the value tupes for the node to typeSet.
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
		 (#(= ~= == ~~ < > <= >= anyMask: allMask: noMask:) includes: expr selector) ifTrue:
			[typeSet add: #sqInt. ^false].
		 (#(+ - * / // \\ rem: quo: bitAnd: bitClear: bitOr: bitXor: bitShift:) includes: expr selector) ifTrue:
			[| types |
			 types := Set new.
			 self addTypesFor: expr receiver to: types in: aCodeGen.
			 (types size = 1 and: [types anyOne last = $*]) ifTrue: "pointer arithmetic"
				[typeSet add: types anyOne. ^false].
			 self addTypesFor: expr args first to: types in: aCodeGen.
			 types := aCodeGen harmonizeReturnTypesIn: types.
			 types size = 2 ifTrue:
				[(types includes: #double) ifTrue:
					[typeSet add: #double. ^false].
				 (types includes: #float) ifTrue:
					[typeSet add: #float. ^false].
				^false]. "don't know; leave unspecified."
			types notEmpty ifTrue:
				[typeSet add: types anyOne].
			^false].
		"Abort only for untyped methods that will be typed, but don't be phased by recursion."
		 ^(aCodeGen returnTypeForSend: expr in: self)
			ifNotNil: [:type| typeSet add: type. false]
			ifNil: [(aCodeGen methodNamed: expr selector) notNil and: [expr selector ~~ selector]]].
	expr isVariable ifTrue:
		[(aCodeGen typeOfVariable: expr name)
			ifNotNil: [:type| typeSet add: type]
			ifNil: [typeSet add: (expr name = 'self'
										ifTrue: [#void]
										ifFalse: [#sqInt])]].
	expr isConstant ifTrue:
		[| val |
		 val := expr value.
		 val isInteger ifTrue:
			[typeSet add: ((val >= 0 ifTrue: [val] ifFalse: [-1 - val]) highBit <= 32
									ifTrue: [#sqInt]
									ifFalse: [#sqLong])].
		 (#(nil true false) includes: val) ifTrue:
			[typeSet add: #sqInt].
		 val isFloat ifTrue:
			[typeSet add: #float]].
	^false