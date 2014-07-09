bootstrap methods
stringFor: aString
	| string |
	string := oldHeap instantiateClass: (oldHeap splObj: ClassByteString) indexableSize: aString size.
	1 to: aString size do:
		[:i| oldHeap storeByte: i - 1 ofObject: string withValue: (aString at: i) asInteger].
	^string
