translation
declareCVarsIn: cg
	super declareCVarsIn: cg.
	cg removeConstant: #COGMTVM "this should be defined at compile time"