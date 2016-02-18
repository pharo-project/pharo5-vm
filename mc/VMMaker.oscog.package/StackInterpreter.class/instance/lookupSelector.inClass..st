debug support
lookupSelector: selector inClass: class
	"Lookup selector in class.  Answer the method or nil.  This is a debugging routine."
	| currentClass dictionary |
	<api>

	currentClass := class.
	[currentClass ~= objectMemory nilObject] whileTrue:
		[dictionary := objectMemory followObjField: MethodDictionaryIndex ofObject: currentClass.
		 dictionary = objectMemory nilObject ifTrue:
			[^nil].
		 (self lookupMethodFor: selector InDictionary: dictionary) ifNotNil:
			[:meth| ^meth].
		currentClass := self superclassOf: currentClass].
	^nil