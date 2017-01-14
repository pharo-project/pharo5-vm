compile abstract instructions
genJumpNotImmediate: aRegister
	<inline: true>
	^self genJumpNotSmallInteger: aRegister