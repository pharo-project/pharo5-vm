public
vmHeaderContentsWithBytesPerWord: bytesPerWord
	"Store C header code on the given stream."

	^ByteString streamContents:
		[:tempStream|
		vmClass writeVMHeaderTo: tempStream bytesPerWord: bytesPerWord]