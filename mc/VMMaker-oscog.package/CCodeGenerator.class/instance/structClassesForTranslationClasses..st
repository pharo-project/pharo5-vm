utilities
structClassesForTranslationClasses: classes
	"Answer in superclass order (any superclass precedes any subclass) the ancilliaryStructClasses for all the given classes."
	| structClasses |

	structClasses := Set new.
	classes do:
		[:aTranslationClass|
		structClasses addAll:
			([aTranslationClass ancilliaryStructClasses]
				on: MessageNotUnderstood
				do: [:ex|
					ex message selector == #ancilliaryStructClasses
						ifTrue: [#()]
						ifFalse: [ex pass]])].
	^Class superclassOrder: structClasses asArray