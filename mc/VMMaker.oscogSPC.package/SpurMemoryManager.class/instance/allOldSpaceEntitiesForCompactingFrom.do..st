object enumeration
allOldSpaceEntitiesForCompactingFrom: initialObject do: aBlock
	<inline: true>
	| prevObj prevPrevObj objOop nextObj |
	self assert: (self isOldObject: initialObject).
	prevPrevObj := prevObj := nil.
	objOop := initialObject.
	[self assert: objOop \\ self allocationUnit = 0.
	 self oop: objOop isLessThan: endOfMemory] whileTrue:
		[self assert: (self long64At: objOop) ~= 0.
		 nextObj := self objectAfter: objOop limit: endOfMemory.
		 aBlock value: objOop value: nextObj.
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := nextObj].
	self touch: prevPrevObj.
	self touch: prevObj