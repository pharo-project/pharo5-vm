object access
byteSizeOf: oop
	<api>
	(self isIntegerObject: oop) ifTrue:[^0].
	^self numBytesOf: oop