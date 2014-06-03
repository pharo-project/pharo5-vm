type inference
addTypesFor: node to: typeSet in: aCodeGen
	| expr |
	expr := node.
	[expr isAssignment or: [expr isStmtList]] whileTrue:
		[expr isAssignment ifTrue:
			[expr := expr variable].
		 expr isStmtList ifTrue:
			[expr := expr statements last]].
	expr isSend ifTrue:
		[(#(ifTrue: ifFalse: ifTrue:ifFalse: ifFalse:ifTrue:) includes: expr selector) ifTrue:
			[^expr args do:
				[:block|
				self addTypesFor: block to: typeSet in: aCodeGen]].
		 (#(= ~= == ~~ < > <= >= anyMask: noMask:) includes: expr selector) ifTrue:
			[^typeSet add: #sqInt].
		 (#(+ - * / // \\ mod: quo: bitAnd: bitClear: bitOr: bitXor: bitShift:) includes: expr selector) ifTrue:
			[| types |
			 types := Set new.
			 self addTypesFor: expr receiver to: types in: aCodeGen.
			 (types size = 1 and: [types anyOne last = $*]) ifTrue: "pointer arithmetic"
				[^typeSet add: types anyOne].
			 self addTypesFor: expr args first to: types in: aCodeGen.
			 types := aCodeGen harmonizeReturnTypesIn: types.
			 types size = 2 ifTrue:
				[(types includes: #double) ifTrue:
					[^typeSet add: #double].
				 (types includes: #float) ifTrue:
					[^typeSet add: #float].
				^self]. "don't know; leave unspecified."
			^types notEmpty ifTrue:
				[typeSet add: types anyOne]].
		 ^(aCodeGen returnTypeForSend: expr) ifNotNil:
			[:type| typeSet add: type]].
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
			[typeSet add: #float]]