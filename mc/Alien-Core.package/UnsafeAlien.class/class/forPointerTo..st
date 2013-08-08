instance creation
forPointerTo: anObject
	"UnsafeAlien forPointerTo: 'You are on your own!', (ByteString with: (Character value: 0))"
	
(anObject class instSpec between: 6 and: 8) ifFalse:
		[^self error: 'only use UnsafeAlien on instances of isBits classes (other than CompiledMethod)!'].
	^self new nonPointerObject: anObject