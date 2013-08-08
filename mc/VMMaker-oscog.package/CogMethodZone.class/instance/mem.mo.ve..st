compaction
mem: destAddress mo: sourceAddress ve: bytes
	<doNotGenerate>
	| dst src  |
	dst := destAddress asInteger.
	src := sourceAddress asInteger.
	"Emulate the c library memmove function"
	self assert: bytes \\ 4 = 0.
	0 to: bytes - 4 by: 4 do:
		[:i|
		objectMemory longAt: dst + i put: (objectMemory longAt: src + i)]