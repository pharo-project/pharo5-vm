translation
exportAPISelectors
	"Yes this is a mess.  When all exportAPI methods are marked with the <api> pragma
	 this can go away."
	| omExports |
	omExports := (self objectMemoryClass withAllSuperclasses copyUpTo: VMClass)
					inject: Set new into: [:api :c| api addAll: c exportAPISelectors; yourself].
	^((self withAllSuperclasses copyUpTo: VMClass),
		self ancilliaryClasses
			inject: omExports
			into: [:set :class| set addAll: (self exportAPISelectorsFor: class); yourself])
	 	addAll: #(	classHeader:
					compactClassIndexOf:
					fetchByte:ofObject:
					functionPointerFor:inClass:
					isNonIntegerObject:
					lastPointerOf:
					literal:ofMethod:
					popStack
					primitiveClosureValueNoContextSwitch
					specialSelector:
					stackTop
					tempCountOf:);
		yourself