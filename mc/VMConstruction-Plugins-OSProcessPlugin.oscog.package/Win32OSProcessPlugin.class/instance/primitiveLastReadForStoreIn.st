primitives - nonblocking read
primitiveLastReadForStoreIn
	"A character has been read into an external buffer corresponding to aSemaphoreIndex,
	and is now available. Answer the integer value of the character, or nil if no character
	was read, or -1 if an error occurred on the read. Store the full results of the most
	recent read into a three element array provided by the sender. Contents of the array
	will be status of the read call, character read, and character count (which should
	always be 1)."

	| index resultArray result |
	<export: true>
	index := interpreterProxy stackIntegerValue: 1.
	resultArray := interpreterProxy stackValue: 0.
	interpreterProxy stObject: resultArray at: 1 put:
		(interpreterProxy positive32BitIntegerFor: (readCharStatusArray at: index)).
	interpreterProxy stObject: resultArray at: 2 put:
		(interpreterProxy integerObjectOf: (readCharBufferArray at: index)).
	interpreterProxy stObject: resultArray at: 3 put:
		(interpreterProxy integerObjectOf: (readCharCountArray at: index)).
	(readCharStatusArray at: index)
		ifFalse:
			[result := interpreterProxy integerObjectOf: -1]
		ifTrue:
			[((readCharCountArray at: index) < 1)
				ifTrue:
					[result := interpreterProxy nilObject]
				ifFalse:
					[result := interpreterProxy integerObjectOf: (readCharBufferArray at: index)]].
	interpreterProxy pop: 3 thenPush: result
