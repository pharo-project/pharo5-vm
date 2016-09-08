translation
declareC: arrayOfVariableNames as: aCType in: aCCodeGenerator
	"Declare the variables in arrayOfVariableNames with the given type."

	arrayOfVariableNames
		do: [:varName | aCCodeGenerator var: varName type: aCType]