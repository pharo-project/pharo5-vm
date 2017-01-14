disassembly
sizeHasModrm: op at: pc
	| modrm mod ro rm |
	modrm := objectMemory byteAt: pc + 1.
	mod := modrm >> 6.
	ro := modrm >> 3 bitAnd: 7.
	rm := modrm bitAnd: 7.
	mod = 3 ifTrue:
		[^2].
	rm ~= 4 ifTrue: "no SIB byte"
		[^mod caseOf:
		   {	[0]	->	[rm = 5
						ifTrue: [6] "reg or 32-bit displacement"
						ifFalse: [3]].
			[1]	->	[3]. "8-bit displacement"
			[2]	->	[6] }].
	self halt: 'fall through in sizeHasModrm:at:'.
	^0