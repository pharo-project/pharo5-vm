message sending
lookupMethodNoMNUEtcInClass: class
	"Lookup messageSelector in class.  Answer 0 on success. Answer the splObj: index
	 for the error selector to use on failure rather than performing MNU processing etc."
	| currentClass dictionary found |
	<inline: false>
	currentClass := class.
	[currentClass ~= objectMemory nilObject] whileTrue:
		[dictionary := objectMemory followObjField: MethodDictionaryIndex ofObject: currentClass.
		 dictionary = objectMemory nilObject ifTrue:
			[lkupClass := self superclassOf: currentClass.
			 ^SelectorCannotInterpret].
		 found := self lookupMethodInDictionary: dictionary.
		 self cppIf: #NewspeakVM
			ifTrue:
				[found ifTrue:
					[(self isPublicMethod: newMethod) ifTrue:
						[self addNewMethodToCache: class. ^0].
					(self isProtectedMethod: newMethod) ifTrue:
						[^SelectorDoesNotUnderstand]]]
			ifFalse:
				[found ifTrue:
					[self addNewMethodToCache: class. ^0]].
		 currentClass := self superclassOf: currentClass].
	lkupClass := class.
	^SelectorDoesNotUnderstand