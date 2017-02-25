C code generation
emitCCodeOn: aStream prependToEnd: aNodeOrNil level: lev generator: gen
	aNodeOrNil ifNotNil:
		[aNodeOrNil prependCCodeOn: aStream level: lev generator: gen].
	self emitCCodeAsExpressionOn: aStream
		level: ((aNodeOrNil notNil and: [self isLeaf]) ifTrue: [0] ifFalse: [lev])
		generator: gen