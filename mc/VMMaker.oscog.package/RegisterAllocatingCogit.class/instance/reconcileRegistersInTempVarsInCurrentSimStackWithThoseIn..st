bytecode generator support
reconcileRegistersInTempVarsInCurrentSimStackWithThoseIn: mergeSimStack
	<var: #mergeSimStack type: #'SimStackEntry *'>
	0 to: methodOrBlockNumTemps - 1 do: 
		[ :i | | current target |
		current := self simStack: simStack at: i.
		target := self simStack: mergeSimStack at: i.
		target registerMaskOrNone ~= 0 
			ifTrue:
				[ target registerMaskOrNone ~= current registerMaskOrNone ifTrue:
					[ self swap: target with: current at: i]]
			ifFalse: [current liveRegister: NoReg]].
	^0