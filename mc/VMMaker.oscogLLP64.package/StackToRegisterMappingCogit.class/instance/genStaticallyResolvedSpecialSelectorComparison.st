bytecode generator support
genStaticallyResolvedSpecialSelectorComparison
	"Assumes both operands are ints"
	<var: #primDescriptor type: #'BytecodeDescriptor *'>
	| rcvrInt argInt primDescriptor result |
	primDescriptor := self generatorAt: byte0.
	argInt := self ssTop constant.
	rcvrInt := (self ssValue: 1) constant.
	self cCode: '' inSmalltalk: "In Simulator ints are unsigned..."
		[rcvrInt := objectMemory integerValueOf: rcvrInt.
		argInt := objectMemory integerValueOf: argInt].
	 primDescriptor opcode caseOf: {
		[JumpLess]				-> [result := rcvrInt < argInt].
		[JumpLessOrEqual]		-> [result := rcvrInt <= argInt].
		[JumpGreater]			-> [result := rcvrInt > argInt].
		[JumpGreaterOrEqual]	-> [result := rcvrInt >= argInt].
		[JumpZero]				-> [result := rcvrInt = argInt].
		[JumpNonZero]			-> [result := rcvrInt ~= argInt] }.
	 "Must annotate the bytecode for correct pc mapping."
	 self ssPop: 2.
	 ^self ssPushAnnotatedConstant: (result
			ifTrue: [objectMemory trueObject]
			ifFalse: [objectMemory falseObject])