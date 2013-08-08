assound
asSound
	"Answer the result of decompressing the receiver."

	| codecClass |
	codecClass := Smalltalk at: codecName
		ifAbsent: [^ self error: 'The codec for decompressing this sound is not available'].
	^ (codecClass new decompressSound: self) reset
