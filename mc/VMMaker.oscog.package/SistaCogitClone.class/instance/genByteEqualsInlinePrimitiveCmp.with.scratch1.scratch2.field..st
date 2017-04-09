inline primitive generators
genByteEqualsInlinePrimitiveCmp: str1Reg with: str2Reg scratch1: scratch1Reg scratch2: scratch2Reg field: index
	| shift |
	<inline: true>
	shift := objectMemory baseHeaderSize + (index * objectMemory wordSize).
	(self ssValue: 1) type = SSConstant 
		ifTrue: [self MoveCq: (objectMemory fetchPointer: index ofObject: (self ssValue: 1) constant) R: scratch1Reg]
		ifFalse: [self MoveMw: shift r: str1Reg R: scratch1Reg].
	 (self ssValue: 2) type = SSConstant 
		ifTrue: [self MoveCq: (objectMemory fetchPointer: index ofObject: (self ssValue: 2) constant) R: scratch2Reg]
		ifFalse: [self MoveMw: shift r: str2Reg R: scratch2Reg].
	self CmpR: scratch1Reg R: scratch2Reg.