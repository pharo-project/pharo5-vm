image save/restore
imageFormatVersion
	"Return a magic constant that changes when the image format changes. Since the image reading code uses
	 this to detect byte ordering, one must avoid version numbers that are invariant under byte reversal."

	"See NewspeakInterpreter class>>declareCVarsIn: and NewspeakInterpreter>>pushClosureCopyCopiedValuesBytecode
	 for the initialization of imageFormatVersionNumber"
	^imageFormatVersionNumber