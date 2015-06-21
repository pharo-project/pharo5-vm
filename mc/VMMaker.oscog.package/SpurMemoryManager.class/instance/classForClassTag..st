interpreter access
classForClassTag: classIndex
	<inline: true>
	"No need to check this; classAtIndex: has a stricter assert:
		self assert: classIndex ~= self isForwardedObjectClassIndexPun."
	^self classAtIndex: classIndex