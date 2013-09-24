object enumeration
firstAccessibleObject
	<inline: false>
	self assert: nilObj = newSpaceLimit.
	"flush newSpace to settle the enumeration."
	self flushNewSpace.
	^nilObj