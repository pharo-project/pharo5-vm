as yet unclassified
declareCVarsIn: aCCodeGenerator

	super declareCVarsIn: aCCodeGenerator.
	aCCodeGenerator var: #k type: #'unsigned int' array: self kArray.
	aCCodeGenerator var: #swap type: #'unsigned int' array: self swapArray