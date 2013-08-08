sound library
updateFMSounds
	"AbstractSound updateFMSounds"

	Sounds keys do: [:k |
		((Sounds at: k) isKindOf: FMSound) ifTrue: [
			Sounds removeKey: k ifAbsent: []]].

	(FMSound class organization listAtCategoryNamed: #instruments) do:
		[:sel | Sounds at: sel asString put: (FMSound perform: sel)].
