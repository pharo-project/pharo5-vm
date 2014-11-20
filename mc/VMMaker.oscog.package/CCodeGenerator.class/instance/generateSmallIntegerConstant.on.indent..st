C translation
generateSmallIntegerConstant: aSendNode on: aStream indent: indent
	aSendNode selector = #minSmallInteger ifTrue:
		[^aStream nextPutAll: 'MinSmallInteger'].
	aSendNode selector = #maxSmallInteger ifTrue:
		[^aStream nextPutAll: 'MaxSmallInteger'].
	self error: 'unknown SmallInteger constant'