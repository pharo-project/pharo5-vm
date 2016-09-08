compile abstract instructions
genJumpNotSmallIntegerInScratchReg: aRegister
	<inline: true>
	^self genJumpNotSmallInteger: aRegister