translation
declareCVarsIn: cg
	super declareCVarsIn: cg.
	cg var: #sCOAFfn type: #'void *'.
