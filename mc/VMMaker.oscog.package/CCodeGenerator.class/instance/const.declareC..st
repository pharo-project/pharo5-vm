public
const: constName declareC: declarationString
	"Record the given C declaration for a constant."

	constants
		at: constName asString
		put: (TDefineNode new
				setName: constName asString
				value: declarationString)