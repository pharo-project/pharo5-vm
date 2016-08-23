object enumeration
allPastSpaceEntitiesDo: aBlock
	"Enumerate all past space objects, including free objects."
	<inline: true>
	| prevObj prevPrevObj objOop |
	prevPrevObj := prevObj := nil.
	objOop := self objectStartingAt: scavenger pastSpace start.
	[self oop: objOop isLessThan: pastSpaceStart] whileTrue:
		[aBlock value: objOop.
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := self objectAfter: objOop limit: pastSpaceStart].
	self touch: prevPrevObj.
	self touch: prevObj