rendering
startIndexOfCopyReplaceWithStringSize: anInteger

	|start|
	flush == #leftFlush ifTrue: [start := 1].
	flush == #rightFlush ifTrue: [start := width - anInteger + 1]. 
	^(start max: 1)
