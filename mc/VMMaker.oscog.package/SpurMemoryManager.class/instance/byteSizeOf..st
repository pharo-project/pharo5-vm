object access
byteSizeOf: oop
	<api>
	(self isImmediate: oop) ifTrue: [^0].
	^self numBytesOf: oop