C library simulation
asString: aStringOrStringIndex
	"aStringOrStringIndex is either a string or an address in the heap.
	 Create a String of the requested length form the bytes in the
	 heap starting at stringIndex."
	<doNotGenerate>
	| sz |
	aStringOrStringIndex isString ifTrue:
		[^aStringOrStringIndex].
	sz := self strlen: aStringOrStringIndex.
	^self st: (ByteString new: sz) rn: aStringOrStringIndex cpy: sz