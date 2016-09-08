message sending
lookupProtectedNoMNU: selector startingAt: mixinApplication rule: rule
	"A shared part of the lookup for self, outer or implicit receiver sends that did not find a
	private lexically visible method, and (Newspeak) super sends."
	| currentClass dictionary found |
	currentClass := mixinApplication.
	[currentClass = objectMemory nilObject] whileFalse:
		[dictionary := objectMemory followObjField: MethodDictionaryIndex ofObject: currentClass.
		found := self lookupMethodInDictionary: dictionary.
		(found and: [(self isPrivateMethod: newMethod) not]) ifTrue:
			[^0].
		currentClass := self superclassOf: currentClass].
	^SelectorDoesNotUnderstand