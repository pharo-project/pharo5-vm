object enumeration
firstAccessibleObject
	<inline: false>
	self assert: nilObj = oldSpaceStart.
	"flush newSpace to settle the enumeration."
	self flushNewSpace.
	^nilObj