C code generation
emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level generator: aCodeGen
	self emitCCommentOn: aStream level: level.
	statements withIndexDo:
		[:s :idx|
		s emitCCommentOn: aStream level: level.
		aStream peekLast ~~ Character tab ifTrue:
			[aStream tab: level].
		(aNodeOrNil notNil
		 and: [idx = statements size])
			ifTrue:
				[s emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level generator: aCodeGen]
			ifFalse:
				[s emitCCodeOn: aStream level: level generator: aCodeGen].
		(self stream: aStream endsWithAnyOf: '};') ifFalse:
			[s needsTrailingSemicolon ifTrue:
				[aStream nextPut: $;]].
		aStream cr].
