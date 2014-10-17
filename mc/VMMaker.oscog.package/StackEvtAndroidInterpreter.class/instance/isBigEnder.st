memory access
isBigEnder
	"Ported from the classic VM as it works well on Android"
	"Answer true (non-zero) if running on a big endian machine."
	| endianness anInt cString len i |
	<var: 'cString' type: 'char *'>
	<var: 'endianness' declareC: 'static sqInt endianness = -1'>
	(endianness == -1) ifFalse: [^ endianness]. "answer cached value"
	len := self cCode: 'sizeof(anInt)'
			inSmalltalk: [^ (Smalltalk endianness == #little) not].
	cString := self cCode: '(char *) &anInt' inSmalltalk: [].
	i := 0.
	[i < len] whileTrue:
		[cString at: i put: i.
		i := i + 1].
	endianness :=  anInt bitAnd: 255.
	^ endianness
