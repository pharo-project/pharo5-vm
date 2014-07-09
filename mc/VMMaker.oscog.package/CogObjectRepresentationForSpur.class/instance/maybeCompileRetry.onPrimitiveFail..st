primitive generators
maybeCompileRetry: retryInst onPrimitiveFail: primIndex
	<var: #retryInst type: #'AbstractInstruction *'>
	"If primIndex has an accessorDepth, check for primitive failure and call
	 ceCheckForAndFollowForwardedPrimitiveStateFor:.  If ceCheck.... answers
	 true, retry the primitive."
	| accessorDepth jmp |
	<var: #jmp type: #'AbstractInstruction *'>
	accessorDepth := coInterpreter accessorDepthForPrimitiveIndex: primIndex.
	accessorDepth < 0 ifTrue:
		[^0].
	cogit MoveAw: coInterpreter primFailCodeAddress R: TempReg.
	cogit CmpCq: 0 R: TempReg.
	jmp := cogit JumpZero: 0.
	cogit
		compileCallFor: #ceCheckForAndFollowForwardedPrimitiveStateFor:
		numArgs: 1
		arg: primIndex
		arg: nil
		arg: nil
		arg: nil
		resultReg: TempReg
		saveRegs: false.
	cogit CmpCq: 0 R: TempReg.
	cogit JumpNonZero: retryInst.
	jmp jmpTarget: cogit Label.
	^0