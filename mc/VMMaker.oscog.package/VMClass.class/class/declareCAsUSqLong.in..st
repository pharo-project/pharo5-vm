translation
declareCAsUSqLong: arrayOfVariableNames in: aCCodeGenerator
	"Declare the variables in arrayOfVariableNames with type representing position in object memory."

	arrayOfVariableNames do:
		[:varName| aCCodeGenerator var: varName type: #usqLong]