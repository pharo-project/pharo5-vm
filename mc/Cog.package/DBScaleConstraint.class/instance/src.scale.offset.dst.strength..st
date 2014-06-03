initialize
src: srcVar scale: scaleVar offset: offsetVar dst: dstVar strength: strengthSymbol
	"Initialize myself with the given variables and strength."

	strength := DBStrength of: strengthSymbol.
	v1 := srcVar.
	v2 := dstVar.
	scale := scaleVar.
	offset := offsetVar.
	direction := nil.
	self addConstraint.