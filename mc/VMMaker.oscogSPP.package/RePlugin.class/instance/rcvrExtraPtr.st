rcvr linkage
rcvrExtraPtr

	|extraObj|
	<inline: true>
	extraObj := interpreterProxy fetchPointer: 3 ofObject: rcvr.
	^self 
		cCoerce: (extraObj = interpreterProxy nilObject
					ifTrue: [nil]
					ifFalse: [interpreterProxy arrayValueOf: extraObj])
		to: #sqInt