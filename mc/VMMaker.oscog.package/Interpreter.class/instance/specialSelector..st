message sending
specialSelector: index

	^ self fetchPointer: (index * 2) ofObject: (self splObj: SpecialSelectors)