class initialization
initialize
	"AssemblerEncoderInterface initialize"
	SpecialSelectors := IdentityDictionary new.
	1 to: Smalltalk specialSelectorSize do:
		[:i | SpecialSelectors at: (Smalltalk specialSelectorAt: i) put: i]