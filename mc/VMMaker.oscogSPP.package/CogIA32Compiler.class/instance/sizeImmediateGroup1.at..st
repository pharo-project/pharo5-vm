disassembly
sizeImmediateGroup1: op at: pc
	"see [1] p A-7, p A-13"
	| modrm mod ro rm |
	modrm := objectMemory byteAt: pc + 1.
	mod := modrm >> 6.
	ro := modrm >> 3 bitAnd: 7.
	rm := modrm bitAnd: 7.
	^ro caseOf:
	   {	[7 "cmp"]	->	[op = 16r81
							ifTrue: [6]
							ifFalse: [3]] }