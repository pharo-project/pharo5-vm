initialize
var: aVariable strength: strengthSymbol
	"Initialize myself with the given variable and strength."

	strength := DBStrength of: strengthSymbol.
	output := aVariable.
	satisfied := false.
	self addConstraint.