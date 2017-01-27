sista support
genGetIdentityHash: rcvrReg resultReg: resultReg
	<var: #jumpSet type: #'AbstractInstruction *'>
	| jumpSet |
	"ReceiverResultReg is required for the trampoline. We force the allocation,
	 and we have two path to avoid conflicts in ReceiverResultReg."
	cogit voidReceiverResultRegContainsSelf. 
	resultReg = ReceiverResultReg 
		ifTrue: 
			[cogit ssTop popToReg: rcvrReg.
			 self genGetHashFieldNonImmOf: rcvrReg asSmallIntegerInto: resultReg.
			 cogit CmpCq: ConstZero R: resultReg.
			 jumpSet := cogit JumpNonZero: 0.
			 cogit MoveR: rcvrReg R: resultReg.
			 cogit CallRT: ceNewHashTrampoline.
			 cogit annotateBytecode: cogit Label]
		ifFalse: 
			[cogit ssTop popToReg: ReceiverResultReg.
		 	 self genGetHashFieldNonImmOf: ReceiverResultReg asSmallIntegerInto: resultReg.
			 cogit CmpCq: ConstZero R: resultReg.
			 jumpSet := cogit JumpNonZero: 0.
			 cogit CallRT: ceNewHashTrampoline.
			 cogit annotateBytecode: (cogit MoveR: ReceiverResultReg R: resultReg)].
	jumpSet jmpTarget: cogit Label.