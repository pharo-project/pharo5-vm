object enumeration
allExistingOldSpaceObjectsDo: aBlock
	"Enumerate all old space objects, excluding any objects created
	 during the execution of allExistingOldSpaceObjectsDo:."
	<inline: true>
	| oldSpaceLimit prevObj prevPrevObj objOop |
	prevPrevObj := prevObj := nil.
	objOop := self firstObject.
	oldSpaceLimit := freeOldSpaceStart.
	[self assert: objOop \\ self allocationUnit = 0.
	 objOop < oldSpaceLimit] whileTrue:
		[(self isFreeObject: objOop) ifFalse:
			[aBlock value: objOop].
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := self objectAfter: objOop limit: freeOldSpaceStart].
	prevPrevObj class.
	prevObj class