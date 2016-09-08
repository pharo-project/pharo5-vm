public
const: constName declareC: declarationString
	"Record the given C declaration for a constant."

	constants
		at: constName
		put: (TDefineNode new
				setName: constName
				value: declarationString)