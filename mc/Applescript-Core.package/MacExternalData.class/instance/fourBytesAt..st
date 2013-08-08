accessing
fourBytesAt: anInteger
	"Answer a string corresponding to the word at anInteger, in accordance with Apple's four byte code convention"

	| val |
	val := self at: anInteger.
	^String streamContents: [:aStream |
		(3 to: 0 by: -1) do: [:i |
			aStream nextPut: (((val >> (i*8)) bitAnd: 16rFF) asCharacter)]]
	