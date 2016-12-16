sista support
mixed: numNonImmediates branchIf: reg instanceOfBehaviors: arrayObj target: targetFixUp
	| jmpImmediate numCases classObj index jmp |
	<var: #jmpImmediate type: #'AbstractInstruction *'>
	<var: #targetFixUp type: #'AbstractInstruction *'>
	<var: #jmp type: #'AbstractInstruction *'>
	numCases := objectMemory numSlotsOf: arrayObj.
	jmpImmediate := self genJumpImmediate: reg.
	
	"Rcvr is non immediate"
	self genGetClassIndexOfNonImm: reg into: TempReg.
	index := 0.
	0 to: numCases - 1 do:
		[:i|
			classObj := objectMemory fetchPointer: i ofObject: arrayObj.
			(objectMemory isImmediateClass: classObj) ifFalse: [
				self genCmpClassIndex: (objectMemory classTagForClass: classObj) R: TempReg.
				cogit JumpZero: targetFixUp.
				index := index + 1 ] ].
	jmp := cogit Jump: 0.
	
	"Rcvr is immediate"
	jmpImmediate jmpTarget: cogit Label.
	numCases - numNonImmediates "num Immediates allowed"
		caseOf:
		{[ 1 ] -> [ "1 immediate needs to jump. Find it and jump."
			0 to: numCases - 1 do:
				[ :j |
				classObj := objectMemory fetchPointer: j ofObject: arrayObj.
				(objectMemory isImmediateClass: classObj) ifTrue: [
					self branchIf: reg hasImmediateTag: (objectMemory classTagForClass: classObj) target: targetFixUp ] ] ] .
		[ 2 ] -> [ "2 immediates needs to jump"
				self branch2CasesIf: reg instanceOfBehaviors: arrayObj target: targetFixUp ] .
		[ 3 ] -> [ "all 3 needs to jump" self Jump: targetFixUp ] }.
	
	jmp jmpTarget: self Label.
	
	^ 0
		