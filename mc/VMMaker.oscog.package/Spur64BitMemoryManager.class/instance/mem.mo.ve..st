simulation only
mem: destAddress mo: sourceAddress ve: bytes
	<doNotGenerate>
	| dst src  |
	dst := destAddress asInteger.
	src := sourceAddress asInteger.
	"Emulate the c library memmove function"
	self assert: bytes \\ 8 = 0.
	destAddress > sourceAddress
		ifTrue:
			[bytes - 8 to: 0 by: -8 do:
				[:i| self longAt: dst + i put: (self longAt: src + i)]]
		ifFalse:
			[0 to: bytes - 8 by: 8 do:
				[:i| self longAt: dst + i put: (self longAt: src + i)]]