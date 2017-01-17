code generation
changedAccesorsForSurrogate: surrogateClass bytesPerWord: bytesPerWord
	"Answer the changed accessor methods for the fields of the receiver and the alignedByteSize class method."

	"{CogBlockMethod changedAccesorsForSurrogate: CogBlockMethodSurrogate32 bytesPerWord: 4.
	 CogMethod changedAccesorsForSurrogate: CogMethodSurrogate32 bytesPerWord: 4.
	 CogBlockMethod changedAccesorsForSurrogate: CogBlockMethodSurrogate64 bytesPerWord: 8.
	 CogMethod changedAccesorsForSurrogate: CogMethodSurrogate64 bytesPerWord: 8}"

	^Dictionary withAll: ((self fieldAccessorSourceFor: surrogateClass bytesPerWord: bytesPerWord) associationsSelect:
		[:a| a value ~= a key sourceString])