message sending
lookupMethodInClass: class
	| currentClass dictionary found rclass |
	<inline: false>

	currentClass := class.
	[currentClass ~= nilObj]
		whileTrue:
		[dictionary := self fetchPointer: MethodDictionaryIndex ofObject: currentClass.
		dictionary = nilObj ifTrue:
			["MethodDict pointer is nil (hopefully due a swapped out stub)
				-- raise exception #cannotInterpret:."
			self pushRemappableOop: currentClass.  "may cause GC!"
			self createActualMessageTo: class.
			currentClass := self popRemappableOop.
			messageSelector := self splObj: SelectorCannotInterpret.
			^ self lookupMethodInClass: (self superclassOf: currentClass)].
		found := self lookupMethodInDictionary: dictionary.
		found ifTrue: [^currentClass].
		currentClass := self superclassOf: currentClass].

	"Could not find #doesNotUnderstand: -- unrecoverable error."
	messageSelector = (self splObj: SelectorDoesNotUnderstand) ifTrue:
		[self error: 'Recursive not understood error encountered'].

	"Cound not find a normal message -- raise exception #doesNotUnderstand:"
	self pushRemappableOop: class.  "may cause GC!"
	self createActualMessageTo: class.
	rclass := self popRemappableOop.
	messageSelector := self splObj: SelectorDoesNotUnderstand.
	^ self lookupMethodInClass: rclass