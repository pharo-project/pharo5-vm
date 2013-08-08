external access
uLawEncodeSample: sample
	"Encode a 16-bit signed sample into 8 bits using uLaw encoding"

	| s |
	s := sample // 8.  "drop 3 least significant bits"
	s < 0 ifTrue: [^ (self uLawEncode12Bits: 0-s) + 16r80]
		ifFalse: [^ (self uLawEncode12Bits: s)].
