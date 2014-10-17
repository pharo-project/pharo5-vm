class initialization
createCodeSkeletons
	"BytecodeSizer createCodeSkeletons"
	"BytecodeEmitter createCodeSkeletons"
	InstructionClient selectorsAndMethodsDo:
		[:s :m|
		Parser new
			initPattern: m getSourceFromFile asString
			notifying: nil
			return:
				[:tuple|
				[:sel :args :precedence|
				self compile:
					(String streamContents:
						[:strm|
						precedence = 1
							ifTrue: [strm nextPutAll: sel]
							ifFalse:
								[sel keywords with: args do:
									[:kw :arg|
									strm nextPutAll: kw; space; nextPutAll: arg; space].
								 strm skip: -1].
						strm crtab; nextPutAll: 'self shouldBeImplemented'])
					classified: #assembly.
				] valueWithArguments: tuple]]