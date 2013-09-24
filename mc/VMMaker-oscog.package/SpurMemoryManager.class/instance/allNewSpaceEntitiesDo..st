object enumeration
allNewSpaceEntitiesDo: aBlock
	"Enumerate all new space objects, including free objects,
	 excluding any objects created during the ennumeration."
	<inline: true>
	| prevObj prevPrevObj objOop limit |
	prevPrevObj := prevObj := nil.
	"After a scavenge eden is empty, futureSpace is empty, and all newSpace objects are
	  in pastSpace.  Objects are allocated in eden.  So enumerate only eden and pastSpace."
	objOop := self objectStartingAt: scavenger eden start.
	[objOop < freeStart] whileTrue:
		[aBlock value: objOop.
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := self objectAfter: objOop limit: freeStart].
	objOop := self objectStartingAt: scavenger pastSpace start.
	limit := pastSpaceStart.
	[objOop < limit] whileTrue:
		[aBlock value: objOop.
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := self objectAfter: objOop limit: limit].
	prevPrevObj class.
	prevObj class