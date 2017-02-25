indexing primitive support
totalByteSizeOf: oop
	<returnTypeC: #usqLong>
	^(self isImmediate: oop)
		ifTrue: [0]
		ifFalse: [self bytesInObject: oop]