constant support
genMoveTrueR: reg
	<inline: true>
	^ self genMoveConstant: objectMemory trueObject R: reg
	