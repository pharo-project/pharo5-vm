object enumeration
allNewSpaceEntitiesDo: aBlock
	"Enumerate all new space objects, including free objects."
	<inline: true>
	| prevObj prevPrevObj objOop limit |
	prevPrevObj := prevObj := nil.
	"After a scavenge eden is empty, futureSpace is empty, and all newSpace objects are
	  in pastSpace.  Objects are allocated in eden.  So enumerate only pastSpace and eden."
	self assert: (scavenger pastSpace start < scavenger eden start).
	objOop := self objectStartingAt: scavenger pastSpace start.
	limit := pastSpaceStart.
	[self oop: objOop isLessThan: limit] whileTrue:
		[aBlock value: objOop.
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := self objectAfter: objOop limit: limit].
	objOop := self objectStartingAt: scavenger eden start.
	[self oop: objOop isLessThan: freeStart] whileTrue:
		[aBlock value: objOop.
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := self objectAfter: objOop limit: freeStart].
	self touch: prevPrevObj.
	self touch: prevObj