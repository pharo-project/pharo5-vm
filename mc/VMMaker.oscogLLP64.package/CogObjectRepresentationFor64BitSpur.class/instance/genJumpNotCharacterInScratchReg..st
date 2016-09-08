compile abstract instructions
genJumpNotCharacterInScratchReg: reg 
	<inline: true>
	^self genJumpNotCharacter: reg