accessing
handleSizeAt: anInteger

	(anInteger < 1 or: [anInteger> self size]) ifTrue: 
		[self error: 'invalid index'].
	^self primGetHandleSize: anInteger - 1