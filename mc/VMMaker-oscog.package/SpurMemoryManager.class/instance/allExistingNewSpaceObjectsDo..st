object enumeration
allExistingNewSpaceObjectsDo: aBlock
	<inline: true>
	| prevObj prevPrevObj objOop limit |
	prevPrevObj := prevObj := nil.
	"After a scavenge eden is empty, futureSpace is empty, and all newSpace objects are
	  in pastSpace.  Objects are allocated in eden.  So enumerate only eden and pastSpace."
	objOop := self objectStartingAt: scavenger eden start.
	limit := freeStart.
	[objOop < limit] whileTrue:
		[(self isFreeObject: objOop) ifFalse:
			[aBlock value: objOop].
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := self objectAfter: objOop limit: freeStart].
	objOop := self objectStartingAt: scavenger pastSpace start.
	limit := pastSpaceStart.
	[objOop < limit] whileTrue:
		[(self isFreeObject: objOop) ifFalse:
			[aBlock value: objOop].
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := self objectAfter: objOop limit: limit].
	prevPrevObj class.
	prevObj class