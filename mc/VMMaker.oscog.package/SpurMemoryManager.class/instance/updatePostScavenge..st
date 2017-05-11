image segment in/out
updatePostScavenge: anObj
	<inline: true>
	^(self isForwarded: anObj) ifTrue: [self followForwarded: anObj] ifFalse: [anObj]