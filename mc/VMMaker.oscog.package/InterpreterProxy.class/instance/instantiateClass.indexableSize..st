instance creation
instantiateClass: classPointer indexableSize: size
	^size = 0 
		ifTrue:[classPointer basicNew]
		ifFalse:[classPointer basicNew: size]