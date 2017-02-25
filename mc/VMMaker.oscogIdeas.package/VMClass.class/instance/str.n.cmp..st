C library simulation
str: aString n: bString cmp: n
	<doNotGenerate>
	"implementation of strncmp(3)"
	bString isString ifTrue:
		[1 to: n do:
			[:i|
			 (aString at: i) asCharacter ~= (bString at: i) ifTrue:
				[^i]].
		 ^0].
	1 to: n do:
		[:i| | v |
		v := (aString at: i) asInteger - (self byteAt: bString + i - 1).
		v ~= 0 ifTrue: [^v]].
	^0