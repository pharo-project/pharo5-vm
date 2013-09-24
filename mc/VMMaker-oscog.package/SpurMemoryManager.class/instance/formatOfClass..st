object format
formatOfClass: classPointer
	<api>
	<inline: true>
	^self integerValueOf: (self fetchPointer: InstanceSpecificationIndex ofObject: classPointer)