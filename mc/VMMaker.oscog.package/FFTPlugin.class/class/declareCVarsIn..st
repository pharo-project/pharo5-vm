translation to C
declareCVarsIn: cg
	cg var: #sinTable type: #'float *'.
	cg var: #realData type:  #'float *'.
	cg var: #imagData type: #'float *'.
	cg var: #permTable type: #'unsigned int *'