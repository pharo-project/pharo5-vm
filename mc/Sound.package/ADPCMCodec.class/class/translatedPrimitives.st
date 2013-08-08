primitive generation
translatedPrimitives
	"Answer a string containing the translated C code for my primitives."
	"Note: This code currently must be hand-edited to remove several methods that are inlined (thus not needed) but not pruned out by the ST-to-C translator."

	^#(
		(ADPCMCodec privateDecodeMono:)
		(ADPCMCodec privateDecodeStereo:)
		(ADPCMCodec privateEncodeMono:)
		(ADPCMCodec privateEncodeStereo:)
		(ADPCMCodec indexForDeltaFrom:to:)
		(ADPCMCodec nextBits:)
		(ADPCMCodec nextBits:put:))
