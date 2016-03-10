compile abstract instructions
genJumpNotSmallFloatInScratchReg: aRegister
	<inline: true>
	^self genJumpNotSmallFloat: aRegister