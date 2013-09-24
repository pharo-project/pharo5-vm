trampolines
ceStackOverflow: contextSwitchIfNotNil
	"If contextSwitchIfNotNil is nil we can't context switch.
	 contextSwitchIfNotNil is set to nil by
		- the special primitiveClosureValueNoContextSwitch entry-point in block dispatch
		- the stack check in methods with primitive 198.
	 In a normal method contextSwitchIfNotNil will be the method (see e.g.
	 SimpleStackBasedCogit>>compileFrameBuild).  In a block it will be the
	 closure (see e.g. SimpleStackBasedCogit>>compileMethodBody)."
	<api>
	| cogMethod switched cesoRetAddr |
	<var: #cogMethod type: #'CogBlockMethod *'>
	cesoRetAddr := self popStack. "discard the ceStackOverflow call return address."
	cogMethod := self mframeCogMethod: framePointer.
	self assert: cesoRetAddr - cogit abortOffset = (self asCogHomeMethod: cogMethod) asInteger.
	instructionPointer := cogMethod asInteger + cogMethod stackCheckOffset.
	self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer imbar: false line: #'__LINE__'.
	method := newMethod := messageSelector := objectMemory nilObject.
	switched := self handleStackOverflowOrEventAllowContextSwitch: contextSwitchIfNotNil ~= 0.
	self returnToExecutive: false postContextSwitch: switched.
	self error: 'should not be reached'
