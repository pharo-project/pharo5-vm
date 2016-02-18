method prototypes
CompiledMethodPROTOTYPEheaderDescription
	"Answer a description containing the information about the form of the
	 receiver and the form of the context needed to run the receiver."

	^(ByteString new: 128) writeStream
		print: self header; cr;
		nextPutAll: '"primitive: '; print: self primitive; cr;
		nextPutAll: ' numArgs: '; print: self numArgs; cr;
		nextPutAll: ' numTemps: '; print: self numTemps; cr;
		nextPutAll: ' numLiterals: '; print: self numLiterals; cr;
		nextPutAll: ' frameSize: '; print: self frameSize; cr;
		nextPutAll: ' bytecodeSet: '; nextPutAll: self bytecodeSetName;
		nextPut: $"; cr;
		contents