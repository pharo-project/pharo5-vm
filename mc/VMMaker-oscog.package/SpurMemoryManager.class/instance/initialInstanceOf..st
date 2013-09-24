object enumeration
initialInstanceOf: classObj
	<inline: false>
	| classIndex |
	classIndex := self rawHashBitsOf: classObj.
	classIndex = 0 ifTrue:
		[^nil].
	"flush newSpace to settle the enumeration."
	self flushNewSpace.
	self allObjectsDo:
		[:objOop|
		classIndex = (self classIndexOf: objOop) ifTrue:
			[^objOop]].
	^nil