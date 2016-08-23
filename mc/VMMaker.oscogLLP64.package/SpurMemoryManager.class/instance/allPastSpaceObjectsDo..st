object enumeration
allPastSpaceObjectsDo: aBlock
	"Enumerate all past space objects, excluding free objects."
	<inline: true>
	self allPastSpaceEntitiesDo:
		[:objOop|
		 self assert: (self isEnumerableObjectNoAssert: objOop).
		 aBlock value: objOop]