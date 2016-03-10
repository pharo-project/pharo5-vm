object testing
isImmediateCharacter: oop
	<inline: true>
	^(oop bitAnd: self tagMask) = self characterTag