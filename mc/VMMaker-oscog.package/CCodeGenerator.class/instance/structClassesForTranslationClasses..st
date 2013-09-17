utilities
structClassesForTranslationClasses: classes
	"Answer in superclass order (any superclass precedes any subclass)
	 the ancilliaryClasses that are struct classes for all the given classes."
	| structClasses |
	structClasses := OrderedCollection new.
	classes do: [ :aTranslationClass |
		([aTranslationClass ancilliaryClasses: self options]
				on: MessageNotUnderstood
				do: [:ex|
					ex message selector == #ancilliaryClasses:
						ifTrue: [#()]
						ifFalse: [ex pass]]) do:
			[:class|
			(class isStructClass
			 and: [(structClasses includes: class) not]) ifTrue:
				[structClasses addLast: class]]].

	^ structClasses asArray