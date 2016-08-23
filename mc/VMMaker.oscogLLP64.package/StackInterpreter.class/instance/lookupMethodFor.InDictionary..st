message sending
lookupMethodFor: selector InDictionary: dictionary
	"Lookup the argument selector in aDictionary and answer either the
	 method or nil, if not found.
	This method lookup tolerates integers as Dictionary keys to support
	 execution of images in which Symbols have been compacted out."
	| length index mask wrapAround nextSelector methodArray |
	<inline: true>
	length := objectMemory numSlotsOf: dictionary.
	mask := length - SelectorStart - 1.
	index := SelectorStart + (objectMemory methodDictionaryHash: selector mask: mask).

	"It is assumed that there are some nils in this dictionary, and search will 
	 stop when one is encountered. However, if there are no nils, then wrapAround 
	 will be detected the second time the loop gets to the end of the table."
	wrapAround := false.
	[true] whileTrue:
		[nextSelector := objectMemory fetchPointer: index ofObject: dictionary.
		 nextSelector = objectMemory nilObject ifTrue:
			[^nil].
		 (objectMemory isOopForwarded: nextSelector) ifTrue:
			[nextSelector := objectMemory
								fixFollowedField: index + SelectorStart
								ofObject: dictionary
								withInitialValue: nextSelector].
		 nextSelector = selector ifTrue:
			[methodArray := objectMemory followObjField: MethodArrayIndex ofObject: dictionary.
			 ^objectMemory followField: index - SelectorStart ofObject: methodArray].
		 index := index + 1.
		 index = length ifTrue:
			[wrapAround ifTrue: [^nil].
			 wrapAround := true.
			 index := SelectorStart]].
	^nil "for Slang"