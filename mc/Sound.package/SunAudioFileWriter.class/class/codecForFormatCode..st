sound storing
codecForFormatCode: formatCode
	"Answer the codec for the given Sun audio file format number."

	formatCode = 1 ifTrue: [^ MuLawCodec new].
	formatCode = 3 ifTrue: [^ nil].  "uncompressed"
	formatCode = 23 ifTrue: [^ ADPCMCodec newBitsPerSample: 4].
	formatCode = 25 ifTrue: [^ ADPCMCodec newBitsPerSample: 3].
	formatCode = 26 ifTrue: [^ ADPCMCodec newBitsPerSample: 5].
	formatCode = 610 ifTrue: [^ GSMCodec new].
	self error: 'unsupported Sun audio format'
