bytecode generator support
genEqualsEqualsForwarderChecksArg: unforwardArg rcvr: unforwardRcvr argReg: argReg rcvrReg: rcvrReg label: label fixup: fixup canBeDead: canBeDead
	"This code generates the forwarders checks if #== is followed by a branch. The forwarders checks need to jump back to the comparison (label) if
	a forwarder is found, else jump forward to the correct place, the postBranch or branch target (fixup), if this is the last forwarder check, or jump to 
	the next forwarder checkif there are 2, or just fall through if it needs to jump to the postBranch and that the branch is dead code"
	<inline: true>
	unforwardArg ifTrue: [ (canBeDead or: [ unforwardRcvr ]) 
		ifTrue: [ objectRepresentation genEnsureOopInRegNotForwarded: argReg scratchReg: TempReg jumpBackTo: label ]
		ifFalse: [ objectRepresentation 
			genEnsureOopInRegNotForwarded: argReg 
			scratchReg: TempReg 
			ifForwarder: label
			ifNotForwarder: fixup ] ].
	unforwardRcvr ifTrue: [ canBeDead 
		ifTrue: [objectRepresentation genEnsureOopInRegNotForwarded: rcvrReg scratchReg: TempReg jumpBackTo: label ]
		ifFalse: [objectRepresentation 
			genEnsureOopInRegNotForwarded: rcvrReg 
			scratchReg: TempReg 
			ifForwarder: label
			ifNotForwarder: fixup ] ]