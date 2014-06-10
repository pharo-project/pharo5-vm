object enumeration
accessibleObjectAfter: objOop
	"Answer the accessible object following the given object or 
	free chunk in the heap. Return nil when heap is exhausted.
	 This is for primitiveNextObject subsequent to primtiiveSomeObject."
	<inline: false>
	| objAfter |
	objAfter := objOop.
	[objAfter := self objectAfter: objAfter limit: endOfMemory.
	 objAfter = endOfMemory ifTrue:
		[^nil].
	 (self isNormalObject: objAfter) ifTrue:
		[^objAfter]] repeat