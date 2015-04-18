bytecode generator support
genMoveFalseR: register
	<inline: true>
	^ self genMoveConstant: objectMemory falseObject R: register
	