wav reading
next16BitWord: msbFirst from: stream
	"Read a 16-bit positive integer from the input stream."
	"Assume: Stream has at least two bytes left."

	| n |
	n := stream next: 2.
	^msbFirst
		ifTrue:[(n at: 1) * 256 + (n at: 2)]
		ifFalse:[(n at: 2) * 256 + (n at: 1)]
