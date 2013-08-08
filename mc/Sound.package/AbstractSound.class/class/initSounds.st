sound library
initSounds
	"AbstractSound initSounds"

	Sounds := Dictionary new.
	(FMSound class organization listAtCategoryNamed: #instruments)
		do: [:sel | Sounds at: sel asString put: (FMSound perform: sel)].
