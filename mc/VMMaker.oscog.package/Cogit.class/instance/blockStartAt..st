compile abstract instructions
blockStartAt: index
	<cmacro: '(index) (&blockStarts[index])'>
	^blockStarts at: index