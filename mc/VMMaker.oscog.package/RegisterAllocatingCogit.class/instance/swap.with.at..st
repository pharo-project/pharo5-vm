bytecode generator support
swap: target with: current at: index
	"Swaps the registers between target and current.
	 target is guaranteed to be in a register. Current is not.
	 If current is in a register, just perform a register swap and update the simStack.
	 If current is not in a register, free the target register and use it.
	 Invariant:
		items in current's simStack up to index have been resolved with target because we are visiting the stack in order 0 to siumStackPtr.
	 Strategy:
		since the target simStack is valid (it has a unique disposition of temps) we can
		spill to obtain registers (since once an entry is written to ther stack its register, if any, can be freed)
		pop to assign after fully spilling (if necessary)"
	| currentLiveRegisters |
	self assert: target registerMaskOrNone ~= 0.
	current registerMaskOrNone ~= 0 ifTrue: 
		[ self SwapR: target liveRegister R: current liveRegister Scratch: RISCTempReg.
		  methodOrBlockNumTemps to: simStackPtr do: 
			[:i| | localCurrent |
			localCurrent := self simStack: simStack at: i.
			localCurrent liveRegister = current liveRegister 
				ifTrue: [ localCurrent liveRegister: target liveRegister ]
				ifFalse: [ localCurrent liveRegister = target liveRegister
						ifTrue: [ localCurrent liveRegister: current liveRegister ] ] ].
		current liveRegister: target liveRegister.
		 ^ 0 ].
	0 to: index -1 do: [:j | self assert: (self simStack: simStack at: j) liveRegister ~= target liveRegister].
	
	currentLiveRegisters := self liveRegistersExceptingTopNItems: 0 in: simStack.
	(self register: target liveRegister isInMask: currentLiveRegisters) ifTrue:
		[self ssAllocateRequiredReg: target liveRegister].
	"Now target liveRegister is available. we set it."
	current storeToReg: target liveRegister.
	^0