compile abstract instructions
blockStartAt: index
	<cmacro: '(index) (&blockStarts[index])'>
	"hack set startpc for printSimStack:toDepth:spillBase:on:"
	self maybeNoteStartpcFor: (blockStarts at: index).
	^blockStarts at: index