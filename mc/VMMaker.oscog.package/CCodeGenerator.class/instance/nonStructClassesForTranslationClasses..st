utilities
nonStructClassesForTranslationClasses: classes
	"Answer in superclass order (any superclass precedes any subclass)
	 the ancilliaryClasses that are not struct classes for all the given classes."
	| nonStructClasses |
	nonStructClasses := OrderedCollection new.
	classes do:
		[:aTranslationClass|
		([aTranslationClass ancilliaryClasses: self options]
				on: MessageNotUnderstood
				do: [:ex|
					ex message selector == #ancilliaryClasses:
						ifTrue: [#()]
						ifFalse: [ex pass]]) do:
			[:class|
			(vmClass isNil or: [vmClass isAcceptableAncilliaryClass: class]) ifTrue:
				[(class isStructClass
				 or: [(nonStructClasses includes: class)
				 or: [classes includes: class]]) ifFalse:
					[nonStructClasses addLast: class]]]].
	^ChangeSet superclassOrder: nonStructClasses