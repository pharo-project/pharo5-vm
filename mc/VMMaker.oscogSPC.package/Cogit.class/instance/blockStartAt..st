compile abstract instructions
blockStartAt: index
	<cmacro: '(index) (&blockStarts[index])'>
	"hack set startpc for printSimStack:toDepth:spillBase:on:"
	(self class initializationOptions at: #tempNames ifAbsent: nil) ifNotNil:
		[self class initializationOptions at: #startpc put: (blockStarts at: index) startpc].
	^blockStarts at: index