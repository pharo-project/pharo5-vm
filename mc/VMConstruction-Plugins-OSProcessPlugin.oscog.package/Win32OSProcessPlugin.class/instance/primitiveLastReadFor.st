primitives - nonblocking read
primitiveLastReadFor
	"A character has been read into an external buffer corresponding to aSemaphoreIndex,
	and is now available. Answer the integer value of the character, or nil if no character
	was read, or -1 if an error occurred on the read."

	| index result |
	<export: true>
	index := interpreterProxy stackIntegerValue: 0.
	(readCharStatusArray at: index)
		ifFalse:
			[result := interpreterProxy integerObjectOf: -1]
		ifTrue:
			[((readCharCountArray at: index) < 1)
				ifTrue:
					[result := interpreterProxy nilObject]
				ifFalse:
					[result := interpreterProxy integerObjectOf: (readCharBufferArray at: index)]].
	interpreterProxy pop: 2 thenPush: result
