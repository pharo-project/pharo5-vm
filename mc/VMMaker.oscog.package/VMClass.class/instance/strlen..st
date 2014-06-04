C library simulation
strlen: aCString
	"Simulate strlen(3)"
	<doNotGenerate>
	| len |
	aCString isString ifTrue:
		[^aCString size].
	len := 0.
	[(self byteAt: aCString + len) = 0 ifTrue: [^len].
	len := len + 1] repeat