initialize
var: variable1 var: variable2 strength: strengthSymbol
	"Initialize myself with the given variables and strength."

	strength := DBStrength of: strengthSymbol.
	v1 := variable1.
	v2 := variable2.
	direction := nil.
	self addConstraint.