as yet unclassified
genPrimitiveNBNativeCall
	| len trailer codeOffset instr trailerSize pos |

	len := (objectMemory lengthOf: methodObj).
	
	trailer := (coInterpreter byteAt: methodObj + BaseHeaderSize + len-1 ).
	(trailer bitAnd: 2r11111100) = 40 " Native code trailer id "
		ifFalse: [ ^ -1"... fail somehow " ].
	
	"see #decodeNativeCodeTrailer implementors
	[... machine code .. ]
	[var-length encoded source pointer
	..
	]
	[trailer size - high ]
	[trailer size - low ]
	[platform id - high]
	[platform id - low]
	[trailer kind]
	"
	pos := methodObj + BaseHeaderSize + len - 1.  "points to trailer kind byte"

	trailerSize := (self byteAt: pos - 3 ) + ((self byteAt: pos - 4)<<8).
	
	pos := pos - 5. "now points to first byte of var-length encoded source pointer"
	
	[ (coInterpreter byteAt: pos) > 127 ] whileTrue: [ pos := pos - 1 ].
	"now pos points prior to last byte of native code"
	
	"entry point address is method oop first byte + len - trailerSize"	
	instr := (self cCoerce: (objectMemory firstFixedField: methodObj) to: 'sqInt') + len - trailerSize.

	"copy machine code"
	self copyInstructionsFrom: instr upTo: pos. 
	
	^ 0