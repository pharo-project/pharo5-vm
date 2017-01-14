code generation
checkGenerateSurrogate: surrogateClass bytesPerWord: bytesPerWord
	"Check the accessor methods for the fields of the receiver and if necessary install new
	 or updated versions in the surrogate class alpng with the alignedByteSize class method."

	"CogBlockMethod checkGenerateSurrogate: CogBlockMethodSurrogate32 bytesPerWord: 4.
	 CogMethod checkGenerateSurrogate: CogMethodSurrogate32 bytesPerWord: 4.
	 CogBlockMethod checkGenerateSurrogate: CogBlockMethodSurrogate64 bytesPerWord: 8.
	 CogMethod checkGenerateSurrogate: CogMethodSurrogate64 bytesPerWord: 8"
	| accessors oldBytesPerWord |
	oldBytesPerWord := BytesPerWord.
	accessors := [self fieldAccessorSourceFor: surrogateClass bytesPerWord: (BytesPerWord := bytesPerWord)]
					ensure: [BytesPerWord := oldBytesPerWord].
	accessors keysAndValuesDo:
		[:mr :source|
		source ~= mr sourceString ifTrue:
			[mr actualClass compile: source classified: #accessing]]

	"Dictionary withAll: ((self fieldAccessorSourceFor: surrogateClass bytesPerWord: bytesPerWord) associationsSelect:
		[:a| a value ~= a key sourceString])"