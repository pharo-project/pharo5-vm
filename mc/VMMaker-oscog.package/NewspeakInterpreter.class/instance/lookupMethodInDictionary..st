message sending
lookupMethodInDictionary: dictionary 
	"This method lookup tolerates integers as Dictionary keys to 
	support execution of images in which Symbols have been 
	compacted out"
	| length index mask wrapAround nextSelector methodArray |
	<inline: true>
	length := self fetchWordLengthOf: dictionary.
	mask := length - SelectorStart - 1.
	(self isIntegerObject: messageSelector)
		ifTrue: [index := (mask bitAnd: (self integerValueOf: messageSelector)) + SelectorStart]
		ifFalse: [index := (mask bitAnd: (self hashBitsOf: messageSelector)) + SelectorStart].

	"It is assumed that there are some nils in this dictionary, and search will 
	stop when one is encountered. However, if there are no nils, then wrapAround 
	will be detected the second time the loop gets to the end of the table."
	wrapAround := false.
	[true] whileTrue:
		[nextSelector := self fetchPointer: index ofObject: dictionary.
		nextSelector = nilObj ifTrue: [^ false].
		nextSelector = messageSelector ifTrue:
			[methodArray := self fetchPointer: MethodArrayIndex ofObject: dictionary.
			newMethod := self fetchPointer: index - SelectorStart ofObject: methodArray.
			^true].
		index := index + 1.
		index = length ifTrue:
			[wrapAround ifTrue: [^false].
			wrapAround := true.
			index := SelectorStart]]