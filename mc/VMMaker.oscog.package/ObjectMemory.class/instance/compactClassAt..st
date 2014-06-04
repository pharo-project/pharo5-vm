interpreter access
compactClassAt: ccIndex
	"Index must be between 1 and compactClassArray size.  A zero compact class
	 index in the base header indicates that the class is in the class header word."
	<api>
	<inline: true>
	^self fetchPointer: ccIndex - 1 ofObject: (self splObj: CompactClasses)