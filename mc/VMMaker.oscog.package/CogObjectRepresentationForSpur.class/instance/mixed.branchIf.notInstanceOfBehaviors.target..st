sista support
mixed: numNonImmediates branchIf: reg notInstanceOfBehaviors: arrayObj target: targetFixUp
	| jmpImmediate jumps label numCases classObj index |
	<var: #label type: #'AbstractInstruction *'>
	<var: #jmpImmediate type: #'AbstractInstruction *'>
	<var: #jumps type: #'AbstractInstruction **'>
	<var: #targetFixUp type: #'AbstractInstruction *'>
	numCases := objectMemory numSlotsOf: arrayObj.
	jmpImmediate := self genJumpImmediate: reg.
	
	"Rcvr is non immediate"
	jumps := self alloca: numNonImmediates type: (self cCode: [#'AbstractInstruction *'] inSmalltalk: [cogit backEnd class]).
	self genGetClassIndexOfNonImm: reg into: TempReg.
	index := 0.
	0 to: numCases - 1 do:
		[:i|
			classObj := objectMemory fetchPointer: i ofObject: arrayObj.
			(objectMemory isImmediateClass: classObj) ifFalse: [
				self genCmpClassIndex: (objectMemory classTagForClass: classObj) R: TempReg.
				jumps at: index put: (cogit JumpZero: 0).
				index := index + 1 ] ].
	cogit Jump: targetFixUp.
	
	"Rcvr is immediate"
	jmpImmediate jmpTarget: cogit Label.
	numCases - numNonImmediates "num Immediates allowed"
		caseOf:
		{[ 1 ] -> [ "1 immediate allowed. jump to targetFixUp if the rcvr is not this immediate"
			0 to: numCases - 1 do:
				[ :j |
				classObj := objectMemory fetchPointer: j ofObject: arrayObj.
				(objectMemory isImmediateClass: classObj) ifTrue: [
					self branchIf: reg hasNotImmediateTag: (objectMemory classTagForClass: classObj) target: targetFixUp ] ] ] .
		[ 2 ] -> [ "2 immediates allowed. On 32 bits nothing to do, all immediate are allowed, on 64 bits generates the jump to fixup for the third tag"
				self branch2CasesIf: reg notInstanceOfBehaviors: arrayObj target: targetFixUp ] .
		[ 3 ] -> [ "nothing to do, all immediates are allowed." ] }.
	
	label := self Label.
	0 to: numNonImmediates - 1 do: [:i |
		(jumps at: i) jmpTarget: label ].
	
	^ 0
		