initialization
genStoreCheckTrampoline
	| jumpSC |
	<var: #jumpSC type: #'AbstractInstruction *'>
	<inline: true>
	CheckRememberedInTrampoline ifTrue:
		[cogit zeroOpcodeIndex.
		 jumpSC := self genCheckRememberedBitOf: ReceiverResultReg scratch: cogit backEnd cResultRegister.
		 self assert: jumpSC opcode = JumpNonZero.
		 jumpSC opcode: JumpZero.
		 cogit RetN: 0.
		 jumpSC jmpTarget: cogit Label].
	^cogit
		genTrampolineFor: #remember:
		called: 'ceStoreCheckTrampoline'
		numArgs: 1
		arg: ReceiverResultReg
		arg: nil
		arg: nil
		arg: nil
		regsToSave: (CallerSavedRegisterMask bitClear: (cogit registerMaskFor: ReceiverResultReg))
		pushLinkReg: true
		resultReg: cogit returnRegForStoreCheck
		appendOpcodes: CheckRememberedInTrampoline