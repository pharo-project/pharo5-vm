rendering
stopIndexOfCopyReplaceWithStringSize: anInteger

	| stop |
	flush == #leftFlush ifTrue: [stop := anInteger].
	flush == #rightFlush ifTrue: [stop := width]. 
	^stop min: width