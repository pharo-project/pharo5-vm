compile abstract instructions
genEnsureOopInRegNotForwarded: reg scratchReg: scratch jumpBackTo: instruction
	<var: #instruction type: #'AbstractInstruction *'>
	^ self 
		genEnsureOopInRegNotForwarded: reg 
		scratchReg: scratch 
		ifForwarder: instruction
		ifNotForwarder: 0