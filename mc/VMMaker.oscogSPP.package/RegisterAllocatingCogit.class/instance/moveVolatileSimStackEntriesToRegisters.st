bytecode generator support
moveVolatileSimStackEntriesToRegisters
	"When jumping forward to a merge point the stack mst be reconcilable with the state that falls through to the merge point.
	 We cannot easily arrange that later we add code to the branch, e.g. to spill values.  Instead, any volatile contents must be
	 moved to registers.  [In fact, that's not exactly true, consider these two code sequences:
							self at: (expr ifTrue: [1] ifFalse: [2]) put: a
							self at: 1 put: (expr ifTrue: [a] ifFalse: [b])
						 The first one needs 1 saving to a register to reconcile with 2.
						 The second one has 1 on both paths, but we're not clever enough to spot this case yet.]
	 Volatile contents are anything not spilled to the stack, because as yet we can only merge registers."
	<inline: true>
	<var: #desc type: #'SimStackEntry *'>
	(simSpillBase max: 0) to: simStackPtr do: 
		[:i| | desc reg |
		 desc := self simStackAt: i.
		 desc spilled
			ifTrue: [simSpillBase := i]
			ifFalse:
				[desc registerOrNone = NoReg ifTrue:
					[reg := self allocateRegNotConflictingWith: 0.
					 reg = NoReg
						ifTrue: [self halt] "have to spill"
						ifFalse: [desc storeToReg: reg]]]]