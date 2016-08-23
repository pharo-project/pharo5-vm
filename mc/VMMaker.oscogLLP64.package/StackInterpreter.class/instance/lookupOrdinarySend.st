message sending
lookupOrdinarySend
	"Do the full lookup for an ordinary send (i.e., a Newspeak or Smalltalk ordinary send or a Smalltalk super send).
	IN: lkupClass
	IN: messageSelector
	IN: argumentCount
	OUT: newMethod
	OUT: primitiveIndex
	RESULT: LookupRuleOrdinary or LookupRuleMNU"
	<option: #NewspeakVM>
	| currentClass dictionary found |
	self assert: (self addressCouldBeClassObj: lkupClass).
	currentClass := lkupClass.
	[currentClass ~= objectMemory nilObject] whileTrue:
		[dictionary := objectMemory followObjField: MethodDictionaryIndex ofObject: currentClass.
		found := self lookupMethodInDictionary: dictionary.
		found ifTrue:
			[(self isPublicMethod: newMethod) ifTrue:
				[^LookupRuleOrdinary].
			(self isProtectedMethod: newMethod) ifTrue:
				[^self lookupMNU]].
		currentClass := self superclassOf: currentClass].
	^self lookupMNU