image segment in/out
enterClassesIntoClassTableFrom: segmentStart to: segmentLimit
 	"This is part of loadImageSegmentFrom:outPointers:.
	 Scan for classes contained in the segment, entering them into the class table,
	 and clearing their isRemembered: bit. Classes are at the front, after the root
	 array and have the remembered bit set. If the attempt succeeds, answer 0,
	 otherwise remove all entered entries and answer an error code."
	| objOop errorCode|
	objOop := self objectAfter: (self objectStartingAt: segmentStart).
	[objOop < segmentLimit
	 and: [self isRemembered: objOop]] whileTrue:
		[self setIsRememberedOf: objOop to: false.
		 (errorCode := self enterIntoClassTable: objOop) ~= 0 ifTrue:
			[| oop |
			 oop := objOop.
			 objOop := self objectAfter: (self objectStartingAt: segmentStart).
			 [objOop < oop] whileTrue:
				[self expungeFromClassTable: objOop.
				 objOop := self objectAfter: objOop limit: segmentLimit].
			 ^errorCode].
		 objOop := self objectAfter: objOop limit: segmentLimit].
	^0