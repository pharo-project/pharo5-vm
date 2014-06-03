translation
declareCVarsIn: cg
	cg var: #zipCollection type: #'unsigned char*'.
	cg var: #zipSource type: #'unsigned char*'.
	cg var: #zipLitTable type: #'unsigned int*'.
	cg var: #zipDistTable type: #'unsigned int*'