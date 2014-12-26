simulation only
mem: destAddress mo: sourceAddress ve: bytes
	<doNotGenerate>
	| dst src  |
	dst := destAddress asInteger.
	src := sourceAddress asInteger.
	"Emulate the c library memmove function"
	self assert: bytes \\ 4 = 0.
	destAddress > sourceAddress
		ifTrue:
			[bytes - 4 to: 0 by: -4 do:
				[:i| self long32At: dst + i put: (self long32At: src + i)]]
		ifFalse:
			[0 to: bytes - 4 by: 4 do:
				[:i| self long32At: dst + i put: (self long32At: src + i)]]