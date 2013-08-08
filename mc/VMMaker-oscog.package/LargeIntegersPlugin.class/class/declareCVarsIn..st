translation
declareCVarsIn: cg 
	cg var: 'andOpIndex' declareC: 'const int  andOpIndex = 0'.
	cg var: 'orOpIndex' declareC: 'const int  orOpIndex = 1'.
	cg var: 'xorOpIndex' declareC: 'const int  xorOpIndex = 2'