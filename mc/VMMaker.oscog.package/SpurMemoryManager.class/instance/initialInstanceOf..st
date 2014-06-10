object enumeration
initialInstanceOf: classObj
	<inline: false>
	| classIndex |
	classIndex := self rawHashBitsOf: classObj.
	classIndex = 0 ifTrue:
		[^nil].
	"flush instances in newSpace to settle the enumeration."
	self flushNewSpaceInstancesOf: classObj.
	self allObjectsDo:
		[:objOop|
		classIndex = (self classIndexOf: objOop) ifTrue:
			[^objOop]].
	^nil