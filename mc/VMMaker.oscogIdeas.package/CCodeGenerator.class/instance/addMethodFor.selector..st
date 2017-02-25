utilities
addMethodFor: aClass selector: selector
	"Add the given method to the code base and answer its translation
	 or nil if it shouldn't be translated."

	| method tmethod |
	method := aClass compiledMethodAt: selector.
	(method pragmaAt: #doNotGenerate) ifNotNil:
		["only remove a previous method if this one overrides it, i.e. this is a subclass method.
		 If the existing method is in a different hierarchy this method must be merely a redeirect."
		 (methods at: selector ifAbsent: []) ifNotNil:
			[:tm|
			(aClass includesBehavior: tm definingClass) ifTrue:
				[self removeMethodForSelector: selector]].
		 ^nil].
	method isSubclassResponsibility ifTrue:
		[^nil].
	(self shouldIncludeMethodFor: aClass selector: selector) ifFalse:
		[^nil].
	tmethod := self compileToTMethodSelector: selector in: aClass.
	"Even thoug we exclude initialize methods, we must consider their
	 global variable usage, otherwise globals may be incorrectly localized."
	selector == #initialize ifTrue:
		[self checkForGlobalUsage: (tmethod allReferencedVariablesUsing: self) in: tmethod.
		 ^nil].
	self addMethod: tmethod.
	"If the method has a macro then add the macro.  But keep the method
	 for analysis purposes (e.g. its variable accesses)."
	(method pragmaAt: #cmacro:) ifNotNil:
		[:pragma|
		self addMacro: (pragma argumentAt: 1) for: selector.
		(inlineList includes: selector) ifTrue:
			[inlineList := inlineList copyWithout: selector]].
	(method pragmaAt: #cmacro) ifNotNil:
		[:pragma| | literal | "Method should be just foo ^const"
		self assert: (method numArgs = 0 and: [method numLiterals = 3 or: [method isQuick]]).
		literal := method isQuick
					ifTrue: [method decompile block statements last expr key]
					ifFalse: [method literalAt: 1].
		self addMacro: '() ', (method isReturnField
								ifTrue: [literal]
								ifFalse: [self cLiteralFor: literal value name: method selector]) for: selector.
		(inlineList includes: selector) ifTrue:
			[inlineList := inlineList copyWithout: selector]].
	^tmethod