utilities
addMethodFor: aClass selector: selector
	"Add the given method to the code base and answer its translation
	 or nil if it shouldn't be translated."

	| method tmethod |
	selector == #initialize ifTrue:
		[^nil].
	method := aClass compiledMethodAt: selector.
	(method pragmaAt: #doNotGenerate) ifNotNil:
		["only remove a previous method if this one overrides it, i.e. this is a subclass method.
		 If the existing method is in a different hierarchy this method must be merely a redeirect."
		 (methods at: selector ifAbsent: []) ifNotNil:
			[:tm|
			(aClass includesBehavior: tm definingClass) ifTrue:
				[methods removeKey: selector]].
		 ^nil].
	method isSubclassResponsibility ifTrue:
		[methods removeKey: selector ifAbsent: [].
		 ^nil].
	(self shouldIncludeMethodFor: aClass selector: selector) ifFalse:
		[methods removeKey: selector ifAbsent: [].
		 ^nil].
	tmethod := self addMethod: (self compileToTMethodSelector: selector in: aClass).
	"If the method has a macro then add the macro.  But keep the method
	 for analysis purposes (e.g. its variable accesses)."
	(method pragmaAt: #cmacro:) ifNotNil:
		[:pragma|
		self addMacro: (pragma argumentAt: 1) for: selector.
		(inlineList includes: selector) ifTrue:
			[inlineList := inlineList copyWithout: selector]].
	(method propertyValueAt: #cmacro:) ifNotNil:
		[:macro|
		self addMacro: macro for: selector.
		(inlineList includes: selector) ifTrue:
			[inlineList := inlineList copyWithout: selector]].
	^tmethod