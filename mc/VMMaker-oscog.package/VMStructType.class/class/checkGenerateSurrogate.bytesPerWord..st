code generation
checkGenerateSurrogate: class bytesPerWord: bytesPerWord
	self checkGenerateFieldAccessors: (self fieldAccessorsForBytesPerWord: bytesPerWord)
		bitPosition: 0
		in: class

	"CogBlockMethod checkGenerateSurrogate: CogBlockMethodSurrogate32 bytesPerWord: 4.
	 CogMethod checkGenerateSurrogate: CogMethodSurrogate32 bytesPerWord: 4"