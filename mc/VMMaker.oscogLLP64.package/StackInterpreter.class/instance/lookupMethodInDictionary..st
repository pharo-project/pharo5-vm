message sending
lookupMethodInDictionary: dictionary 
	"This method lookup tolerates integers as Dictionary keys to support
	 execution of images in which Symbols have been compacted out."
	| length index mask wrapAround nextSelector methodArray |
	<inline: true>
	length := objectMemory numSlotsOf: dictionary.
	mask := length - SelectorStart - 1.
	"Use linear search on small dictionaries; its cheaper.
	 Also the limit can be set to force linear search of all dictionaries, which supports the
	 booting of images that need rehashing (e.g. because a tracer has generated an image
	 with different hashes but hasn't rehashed it yet.)"
	mask <= methodDictLinearSearchLimit ifTrue:
		[index := 0.
		 [index <= mask] whileTrue:
			[nextSelector := objectMemory fetchPointer: index + SelectorStart ofObject: dictionary.
			 (objectMemory isOopForwarded: nextSelector) ifTrue:
				[nextSelector := objectMemory
									fixFollowedField: index + SelectorStart
									ofObject: dictionary
									withInitialValue: nextSelector].
			 nextSelector = messageSelector ifTrue:
				[methodArray := objectMemory followObjField: MethodArrayIndex ofObject: dictionary.
				 newMethod := objectMemory followField: index ofObject: methodArray.
				^true].
		 index := index + 1].
		 ^false].
	index := SelectorStart + (objectMemory methodDictionaryHash: messageSelector mask: mask).

	"It is assumed that there are some nils in this dictionary, and search will 
	 stop when one is encountered. However, if there are no nils, then wrapAround 
	 will be detected the second time the loop gets to the end of the table."
	wrapAround := false.
	[true] whileTrue:
		[nextSelector := objectMemory fetchPointer: index ofObject: dictionary.
		 nextSelector = objectMemory nilObject ifTrue: [^false].
		 (objectMemory isOopForwarded: nextSelector) ifTrue:
			[nextSelector := objectMemory
								fixFollowedField: index + SelectorStart
								ofObject: dictionary
								withInitialValue: nextSelector].
		 nextSelector = messageSelector ifTrue:
			[methodArray := objectMemory followObjField: MethodArrayIndex ofObject: dictionary.
			 newMethod := objectMemory followField: index - SelectorStart ofObject: methodArray.
			^true].
		 index := index + 1.
		 index = length ifTrue:
			[wrapAround ifTrue: [^false].
			 wrapAround := true.
			 index := SelectorStart]].
	
	^false "for Slang"