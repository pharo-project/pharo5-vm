compile abstract instructions
genEnsureOopInRegNotForwarded: reg scratchReg: scratch jumpBackTo: instruction
	^ self 
		genEnsureOopInRegNotForwarded: reg 
		scratchReg: scratch 
		ifForwarder: instruction
		ifNotForwarder: 0