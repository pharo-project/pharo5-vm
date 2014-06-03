weakness and ephemerality
allFutureSpaceEntitiesDo: aBlock
	"Enumerate all future space objects, including free objects."
	<inline: true>
	| prevObj prevPrevObj objOop limit |
	prevPrevObj := prevObj := nil.
	objOop := manager objectStartingAt: futureSpace start.
	limit := futureSurvivorStart.
	[self oop: objOop isLessThan: limit] whileTrue:
		[aBlock value: objOop.
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := manager objectAfter: objOop limit: limit]