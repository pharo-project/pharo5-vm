object enumeration
allNewSpaceObjectsDo: aBlock
	"Enumerate all new space objects, excluding free objects."
	<inline: true>
	self allNewSpaceEntitiesDo:
		[:objOop|
		 self assert: (self isEnumerableObjectNoAssert: objOop).
		 aBlock value: objOop]