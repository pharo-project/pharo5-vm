snapshot
swizzleFieldsOfObject: oop
	| fieldAddr fieldOop |
	<inline: true>
	fieldAddr := oop + (self lastPointerOfWhileSwizzling: oop).
	[self oop: fieldAddr isGreaterThanOrEqualTo: oop + self baseHeaderSize] whileTrue:
		[fieldOop := self longAt: fieldAddr.
		 (self isNonImmediate: fieldOop) ifTrue:
			[self longAt: fieldAddr put: (segmentManager swizzleObj: fieldOop)].
		 fieldAddr := fieldAddr - self bytesPerOop]