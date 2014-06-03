initialization
compactIndexOfClass: aClassOop
	"Check that a class the VM assumes is compact has the right index."
	| cct |
	cct := self splObj: CompactClasses.
	(self lengthOf: cct) - 1 to: 0 by: -2 do:
		[:index|
		(self fetchPointer: index ofObject: cct) = aClassOop ifTrue:
			[^index + 1]].
	^0