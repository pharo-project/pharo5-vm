compile abstract instructions
genEnsureOopInRegNotForwarded: reg scratchReg: scratch jumpBackTo: instruction
	<inline: true>
	^ self 
		genEnsureOopInRegNotForwarded: reg 
		scratchReg: scratch 
		ifForwarder: instruction
		ifNotForwarder: 0