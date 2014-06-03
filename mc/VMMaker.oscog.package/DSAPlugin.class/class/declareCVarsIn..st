translation
declareCVarsIn: cg
	cg var: #dsaRemainder type: #'unsigned char*'.
	cg var: #dsaDivisor type:  #'unsigned char*'.
	cg var: #dsaQuotient type: #'unsigned char*'