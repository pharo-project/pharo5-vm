object enumeration
allExistingOldSpaceObjectsDo: aBlock
	"Enumerate all old space objects, excluding any objects created
	 during the execution of allExistingOldSpaceObjectsDo:."
	<inline: true>
	| oldSpaceLimit prevObj prevPrevObj objOop |
	prevPrevObj := prevObj := nil.
	objOop := self firstObject.
	oldSpaceLimit := endOfMemory.
	[self assert: objOop \\ self allocationUnit = 0.
	 self oop: objOop isLessThan: oldSpaceLimit] whileTrue:
		[(self isEnumerableObject: objOop) ifTrue:
			[aBlock value: objOop].
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := self objectAfter: objOop limit: oldSpaceLimit].
	self touch: prevPrevObj.
	self touch: prevObj