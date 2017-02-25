sista support
fetchImmediateTagOtherThanTag1: tag1 tag2: tag2
	"Answers the immediate tag which is not tag1 nor tag2, usually Character."
	<inline: true>
	(tag1 = objectMemory characterTag or: [ tag2 = objectMemory characterTag ]) ifFalse: 
		[ ^ objectMemory characterTag ].
	(tag1 = objectMemory smallIntegerTag or: [ tag2 = objectMemory smallIntegerTag ]) ifFalse: 
		[ ^ objectMemory smallIntegerTag ].
	^ objectMemory smallFloatTag