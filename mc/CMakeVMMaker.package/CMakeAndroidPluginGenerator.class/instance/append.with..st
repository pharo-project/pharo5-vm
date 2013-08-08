gmake commands
append: variableName with: aValueString

	output 
		nextPutAll: (variableName, ' += ', aValueString); 
		cr
