C code generation
emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level generator: aCodeGen
	self emitCCommentOn: aStream level: level generator: aCodeGen.
	statements withIndexDo:
		[:s :idx| | position |
		s emitCCommentOn: aStream level: level generator: aCodeGen.
		(s isLeaf and: [s isLabel not and: [aNodeOrNil isNil or: [idx < statements size]]]) ifFalse:
			[aStream peekLast ~~ Character tab ifTrue:
				[aStream tab: level].
			position := aStream position.
			(aNodeOrNil notNil
			 and: [idx = statements size])
				ifTrue:
					[s emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level generator: aCodeGen]
				ifFalse:
					[s emitCCodeOn: aStream level: level generator: aCodeGen].
			aStream position > position ifTrue:
				[(self stream: aStream endsWithAnyOf: '};') ifFalse:
					[s needsTrailingSemicolon ifTrue:
						[aStream nextPut: $;]].
					 aStream peekLast ~~ Character cr ifTrue:
						[aStream cr]]]]