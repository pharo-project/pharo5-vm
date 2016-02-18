become implementation
isOopValidBecome: oop
	"Answers 0 if the oop can be become.
	Answers an error code in the other case"
	(self isImmediate: oop) ifTrue: [^PrimErrInappropriate].
	(self isPinned: oop) ifTrue: [^PrimErrObjectIsPinned].
	(self isObjImmutable: oop) ifTrue: [^PrimErrNoModification].
	^0