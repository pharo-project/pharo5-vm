compile abstract instructions
genEnsureOopInRegNotForwarded: reg scratchReg: scratch
	^ self 
		genEnsureOopInRegNotForwarded: reg 
		scratchReg: scratch 
		jumpBackTo: cogit Label "label is just before the forwarder check"