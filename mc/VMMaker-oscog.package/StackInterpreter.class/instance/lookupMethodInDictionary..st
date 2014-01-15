message sending
lookupMethodInDictionary: dictionary 
	"This method lookup tolerates integers as Dictionary keys to suoport
	 execution of images in which Symbols have been compacted out."
	| length index mask wrapAround nextSelector methodArray |
	<inline: true>
	<asmLabel: false>
	length := objectMemory fetchWordLengthOf: dictionary.
	mask := length - SelectorStart - 1.
	index := SelectorStart + (mask bitAnd: ((objectMemory isIntegerObject: messageSelector)
												ifTrue: [objectMemory integerValueOf: messageSelector]
												ifFalse: [objectMemory hashBitsOf: messageSelector])).

	"It is assumed that there are some nils in this dictionary, and search will 
	 stop when one is encountered. However, if there are no nils, then wrapAround 
	 will be detected the second time the loop gets to the end of the table."
	wrapAround := false.
	[true] whileTrue:
		[nextSelector := objectMemory fetchPointer: index ofObject: dictionary.
		 nextSelector = objectMemory nilObject ifTrue: [^ false].
		 nextSelector = messageSelector ifTrue:
			[methodArray := objectMemory fetchPointer: MethodArrayIndex ofObject: dictionary.
			 newMethod := objectMemory fetchPointer: index - SelectorStart ofObject: methodArray.
			^true].
		 index := index + 1.
		 index = length ifTrue:
			[wrapAround ifTrue: [^false].
			 wrapAround := true.
			 index := SelectorStart]].
	^false "for Slang"