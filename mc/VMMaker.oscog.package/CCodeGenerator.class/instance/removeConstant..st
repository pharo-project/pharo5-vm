utilities
removeConstant: aName
	"Remove the given (class) variable from the code base."

	constants removeKey:  aName ifAbsent: []