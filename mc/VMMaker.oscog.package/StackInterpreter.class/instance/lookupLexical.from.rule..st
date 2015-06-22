message sending
lookupLexical: selector from: mixin rule: rule
	"A shared part of the lookup for implicit receiver sends that found a lexically visible
	method, and self and outer sends."
	| receiverClass mixinApplication dictionary found |
	receiverClass := objectMemory fetchClassOf: localAbsentReceiver.
	lkupClass := receiverClass. "For use by MNU"
	mixinApplication := self findApplicationOfTargetMixin: mixin startingAtBehavior: receiverClass.
	dictionary := objectMemory followObjField: MethodDictionaryIndex ofObject: mixinApplication.
	found := self lookupMethodInDictionary: dictionary.
	(found and: [(self accessModifierOfMethod: newMethod) = AccessModifierPrivate])
		ifTrue: [^rule].
	^self lookupProtected: selector startingAt: receiverClass rule: rule
