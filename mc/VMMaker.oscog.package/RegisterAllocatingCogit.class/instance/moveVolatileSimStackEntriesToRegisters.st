bytecode generator support
moveVolatileSimStackEntriesToRegisters
	"When jumping forward to a merge point the stack must be reconcilable with the state that falls through to the merge point.
	 We cannot easily arrange that later we add code to the branch, e.g. to spill values.  Instead, any volatile contents must be
	 moved to registers.
		[In fact, that's not exactly true, consider these two code sequences:
							self at: (expr ifTrue: [1] ifFalse: [2]) put: a
							self at: 1 put: (expr ifTrue: [a] ifFalse: [b])
						 The first one needs 1 saving to a register to reconcile with 2.
						 The second one has 1 on both paths, but we're not clever enough to spot this case yet.
		 First of all, if the constant requires an annotation then it is difficult to deal with.  But if the constant
		 does not require an annotation one way would be for a SimStackEntry for an SSConstant to refer to
		 the loading instruction and then at the merge simply change the loading instruction to a Label if the
		 constant is the same on both branches].
	 Volatile contents are anything not spilled to the stack, because as yet we can only merge registers."
	<inline: true>
	| allocatedRegs |
	<var: #desc type: #'SimStackEntry *'>
	allocatedRegs := self allocatedRegisters.
	(simSpillBase max: 0) to: simStackPtr do: 
		[:i| | desc reg |
		 desc := self simStackAt: i.
		 desc spilled
			ifTrue: [simSpillBase := i]
			ifFalse:
				[desc registerOrNone = NoReg ifTrue:
					[reg := self allocateRegNotConflictingWith: allocatedRegs.
					 reg = NoReg
						ifTrue: [self halt] "have to spill"
						ifFalse:
							[desc storeToReg: reg.
							 allocatedRegs := allocatedRegs bitOr: (self registerMaskFor: reg)]]]].
	self deny: self duplicateRegisterAssignmentsInTemporaries