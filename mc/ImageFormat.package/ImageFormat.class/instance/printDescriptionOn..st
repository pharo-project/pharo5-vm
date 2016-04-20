printing
printDescriptionOn: stream

		stream nextPutAll: 'a ';
			nextPutAll: (wordSize * 8) asString;
			nextPutAll: '-bit image with '.
		self requiresClosureSupport ifFalse: [stream nextPutAll: 'no '].
		stream nextPutAll: 'closure support and '.
		self requiresNativeFloatWordOrder
			ifTrue: [stream nextPutAll: 'float words stored in native platform order']
			ifFalse: [stream nextPutAll: 'no native platform float word order requirement'].
		self requiresSpurSupport
			ifTrue: [stream nextPutAll: ' using Spur object format'.
				(self is64Bit and: [self requiresNewSpur64TagAssignment not])
					ifTrue: [stream nextPutAll: ' (obsolete)']].
		stream nextPutAll: ' (';
			nextPutAll: self asInteger asString;
			nextPut: $).
		^ stream
