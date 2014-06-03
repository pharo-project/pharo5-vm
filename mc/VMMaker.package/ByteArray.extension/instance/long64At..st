*VMMaker-accessing
long64At: index
	"Answer a 64-bit integer in Smalltalk order (little-endian)."
	| n1 n2 |
	n1 := self unsignedLongAt: index bigEndian: true.
	n2 := self unsignedLongAt: index+4 bigEndian: true.
	^(n1 bitShift: 32) + n2