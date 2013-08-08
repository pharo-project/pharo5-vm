wav reading
next32BitWord: msbFirst from: stream
	"Read a 32-bit positive integer from the input stream."
	"Assume: Stream has at least four bytes left."

	| n |
	n := stream next: 4.
	^msbFirst
		ifTrue:[(n at: 1) * 256 + (n at: 2) * 256 + (n at: 3) * 256 + (n at: 4)]
		ifFalse:[(n at: 4) * 256 + (n at: 3) * 256 + (n at: 2) * 256 + (n at: 1)]
