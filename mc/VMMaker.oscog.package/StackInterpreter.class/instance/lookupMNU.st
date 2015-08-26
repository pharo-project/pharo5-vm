message sending
lookupMNU
	"A send lookup failed. Replace the arguments on the stack with a Message and lookup
	 #doesNotUndestand: starting at lkupClass. Note that MNU lookup ignores access modifiers.
	 This makes it different from an ordinary send of #doesNotUnderstand:, which must only
	 find public methods.
	IN: lkupClass
	IN: messageSelector
	IN: argumentCount
	OUT: newMethod
	OUT: primitiveIndex
	RESULT: LookupRuleMNU"

	| currentClass dictionary found |
	self createActualMessageTo: lkupClass.
	messageSelector := objectMemory splObj: SelectorDoesNotUnderstand.
	currentClass := lkupClass.
	[currentClass ~= objectMemory nilObject] whileTrue:
		[dictionary := objectMemory followObjField: MethodDictionaryIndex ofObject: currentClass.
		found := self lookupMethodInDictionary: dictionary.
		found ifTrue: [^LookupRuleMNU].
		currentClass := self superclassOf: currentClass].

	self error: 'Recursive not understood error encountered'
