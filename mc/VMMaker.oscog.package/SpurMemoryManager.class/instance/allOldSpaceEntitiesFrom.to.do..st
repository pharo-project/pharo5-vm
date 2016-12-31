object enumeration
allOldSpaceEntitiesFrom: initialObject to: finalObject do: aBlock
	<inline: true>
	| prevObj prevPrevObj objOop |
	self assert: ((self isNonImmediate: initialObject) and: [segmentManager isInSegments: initialObject]).
	self assert: ((self isNonImmediate: finalObject) and: [segmentManager isInSegments: finalObject]).
	prevPrevObj := prevObj := nil.
	objOop := initialObject.
	[self assert: objOop \\ self allocationUnit = 0.
	 self oop: objOop isLessThanOrEqualTo: finalObject] whileTrue:
		[self assert: (self long64At: objOop) ~= 0.
		 aBlock value: objOop.
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := self objectAfter: objOop limit: endOfMemory].
	self touch: prevPrevObj.
	self touch: prevObj