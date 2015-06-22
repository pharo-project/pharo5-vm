message sending
lookupDnuPresent
	"A present receiver send lookup failed. Replace the arguments on the stack with
	 a Message and lookup #doesNotUndestand:.
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