inlining
isNode: aNode substitutableFor: argName inMethod: targetMeth in: aCodeGen
	"Answer if the given parameter node may be substituted directly into the body of
	 the method during inlining, instead of being bound to the actual parameter variable.
	 We allow a constant, a local variable, or a formal parameter, or simple expressions
	 involving only these to to be directly substituted. Note that global variables cannot
	 be subsituted into methods with possible side effects (i.e., methods that may assign
	 to global variables) because the inlined method might depend on having the value of
	 the global variable captured when it is passed in as an argument."

	| madeNonTrivialCall count constantExpression usageCount |
	aNode isConstant ifTrue: [^true].

	aNode isVariable ifTrue:
		[((locals includes: aNode name)
		 or: [(args includes: aNode name)
		 or: [#('self' 'true' 'false' 'nil') includes: aNode name]]) ifTrue: [^true].
		"We can substitute any variable provided it is only read in the method being inlined,
		 and if it is not read after any non-trivial call (which may update the variable)."
		madeNonTrivialCall := false.
		(targetMeth isComplete
		 and: [targetMeth parseTree
				noneSatisfy:
					[:node|
					 (node isSend
					  and: [(aCodeGen isBuiltinSelector: node selector) not]) ifTrue:
						[madeNonTrivialCall := true].
					 (madeNonTrivialCall and: [node isVariable and: [node name = argName]])
					 or: [node isAssignment
						  and: [node variable name = argName]]]
				unless:
					[:node|
					node isSend and: [aCodeGen isAssertSelector: node selector]]]) ifTrue:
			[^true].
		^targetMeth maySubstituteGlobal: aNode name in: aCodeGen].

	"don't much up asserts with complex expansions"
	(targetMeth usesVariableUninlinably: argName in: aCodeGen) ifTrue:
		[^false].

	"For now allow literal blocks to be substituted.  They better be accessed only
	 with value[:value:*] messages though!"
	aNode isStmtList ifTrue: [^true].

	"Don't inline expressions unless type-compatible,"
	aNode isSend ifTrue:
		[(aCodeGen
				isActualType: (aCodeGen returnTypeForSend: aNode in: self ifNil: #incompatible)
				compatibleWithFormalType: (self typeFor: argName in: aCodeGen)) ifFalse:
			[^false]].

	count := 0.
	constantExpression := true.
	"scan expression tree; must contain only constants, builtin ops, and inlineable vars"
	aNode nodesDo:
		[:node|
		node isConstant
			ifTrue: [] ifFalse:
		[node isSend
			ifTrue:
				[((VMBasicConstants mostBasicConstantSelectors includes: node selector)
				  or: [node isBuiltinOperator]) ifFalse: [^false].
				 count := count + 1] ifFalse:
		[node isVariable ifTrue:
			[(aCodeGen isNonArgumentImplicitReceiverVariableName: node name) ifFalse:
				[constantExpression := false.
				((locals includes: node name)
				 or: [(args includes: node name)
				 or: [(#('self' 'true' 'false' 'nil') includes: node name)
				 or: [targetMeth maySubstituteGlobal: node name in: aCodeGen]]]) ifFalse: [^false]]] ifFalse:
		[^false]]]].
	"inline constant expressions"
	constantExpression ifNil: [^true].

	"scan target to find usage count"
	usageCount := 0.
	targetMeth parseTree nodesDo:
		[:node|
		(node isVariable and: [node name = argName]) ifTrue:
			[usageCount := usageCount + 1]].
	"(usageCount > 1 and: [count <= usageCount]) ifTrue:
		[[UsageCounts := Dictionary new.
		  self removeClassVarName: #UsageCounts].
		 (UsageCounts at: usageCount ifAbsentPut: [Set new]) add: ({targetMeth. argName. aNode})]."
	"Now only inline expressions if they are used only once or are simple
	 w.r.t. the usage count, and the usage count is not large; a heuristic that seems to work well enough."
	^usageCount = 1 or: [usageCount <= 7 and: [count <= usageCount]]