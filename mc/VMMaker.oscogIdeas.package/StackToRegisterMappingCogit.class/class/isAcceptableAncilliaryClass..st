translation
isAcceptableAncilliaryClass: aClass
	^(aClass includesBehavior: CogBytecodeFixup)
		ifTrue: [aClass == self basicNew bytecodeFixupClass]
		ifFalse:
			[(aClass includesBehavior: CogSimStackEntry)
				ifTrue: [aClass == self basicNew simStackEntryClass]
				ifFalse: [true]]