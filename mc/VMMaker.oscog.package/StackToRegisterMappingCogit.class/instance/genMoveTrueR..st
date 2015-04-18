bytecode generator support
genMoveTrueR: register
	<inline: true>
	^ self genMoveConstant: objectMemory trueObject R: register
	