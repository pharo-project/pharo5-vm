callback support
lookupMethodNoMNUEtcInClass: class
	"Lookup messageSelector in class.  Answer 0 on success. Answer the splObj: index
	 for the error selector to use on failure rather than performing MNU processing etc."
	| currentClass dictionary |
	<inline: true>

	currentClass := class.
	[currentClass ~= nilObj] whileTrue:
		[dictionary := self fetchPointer: MessageDictionaryIndex ofObject: currentClass.
		 dictionary = nilObj ifTrue:
			[lkupClass := self superclassOf: currentClass.
			 ^SelectorCannotInterpret].
		(self lookupMethodInDictionary: dictionary) ifTrue:
			[self addNewMethodToCache.
			 ^0].
		currentClass := self superclassOf: currentClass].

	^SelectorDoesNotUnderstand