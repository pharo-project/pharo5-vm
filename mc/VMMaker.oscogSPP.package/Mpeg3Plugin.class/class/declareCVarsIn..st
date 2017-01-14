initialize-release
declareCVarsIn: cg 
	super declareCVarsIn: cg.
	cg var: 'mpegFiles' declareC: 'mpeg3_t *mpegFiles[1024+1]'.
