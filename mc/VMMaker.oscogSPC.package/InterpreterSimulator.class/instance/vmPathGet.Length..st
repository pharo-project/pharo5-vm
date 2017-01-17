file primitives
vmPathGet: stringBase Length: stringSize
	| pathName stringOop |
	pathName := Smalltalk vmPath.
	stringOop := stringBase - self baseHeaderSize. "Due to C call in Interp"
	1 to: stringSize do:
		[:i | self storeByte: i-1 ofObject: stringOop
			withValue: (pathName at: i) asciiValue].
