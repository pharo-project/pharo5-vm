constant support
genMoveFalseR: reg
	<inline: true>
	^ self genMoveConstant: objectMemory falseObject R: reg
	