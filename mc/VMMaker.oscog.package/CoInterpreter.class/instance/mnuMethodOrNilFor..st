message sending
mnuMethodOrNilFor: rcvr
	"Lookup the doesNotUnderstand: selector in the class of the argument rcvr.
	 Answer either the matching method (cogged if appropriate), or nil, if not found."
	| currentClass mnuSelector dictionary mnuMethod methodHeader |
	self deny: (objectMemory isOopForwarded: rcvr).
	currentClass := objectMemory fetchClassOf: rcvr.
	mnuSelector := objectMemory splObj: SelectorDoesNotUnderstand.
	[currentClass ~= objectMemory nilObject] whileTrue:
		[dictionary := objectMemory fetchPointer: MethodDictionaryIndex ofObject: currentClass.
		 dictionary = objectMemory nilObject ifTrue:
			[^nil].
		 mnuMethod := self lookupMethodFor: mnuSelector InDictionary: dictionary.
		 mnuMethod ifNotNil:
			[methodHeader := self rawHeaderOf: mnuMethod.
			 ((self isCogMethodReference: methodHeader) not
			  and: [self methodWithHeaderShouldBeCogged: methodHeader]) ifTrue:
				[cogit cog: mnuMethod selector: mnuSelector].
			^mnuMethod].
		currentClass := self superclassOf: currentClass].
	^nil