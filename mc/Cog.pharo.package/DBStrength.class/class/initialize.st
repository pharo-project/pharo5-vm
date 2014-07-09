initialize
initialize
	"Initialize the symbolic strength table. Fix the internally caches
	 values of all existing instances."
	"Strength initialize"

	StrengthTable := Dictionary new.
	StrengthTable at: #absoluteStrongest put: -10000.
	StrengthTable at: #required put: -800.
	StrengthTable at: #strongPreferred put: -600.
	StrengthTable at: #preferred put: -400.
	StrengthTable at: #strongDefault put: -200.
	StrengthTable at: #default put: 0.
	StrengthTable at: #weakDefault put: 500.
	StrengthTable at: #absoluteWeakest put: 10000.

	StrengthConstants := Dictionary new.
	StrengthTable keys do:
		[: strengthSymbol |
			StrengthConstants
				at: strengthSymbol
				put: ((super new) initializeWith: strengthSymbol)].

	AbsoluteStrongest := DBStrength of: #absoluteStrongest.
	AbsoluteWeakest := DBStrength of: #absoluteWeakest.
	Required := DBStrength of: #required.