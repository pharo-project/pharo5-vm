object enumeration
allOldSpaceEntitiesForCompactingFrom: initialObject to: finalObject do: aBlock
	<inline: true>
	| limit prevObj prevPrevObj objOop nextObj |
	self assert: (self isOldObject: initialObject).
	self assert: (self oop: finalObject isLessThanOrEqualTo: endOfMemory).
	prevPrevObj := prevObj := nil.
	objOop := initialObject.
	limit := (self oop: finalObject isLessThan: endOfMemory) ifTrue: [self addressAfter: finalObject] ifFalse: [endOfMemory].
	[self assert: objOop \\ self allocationUnit = 0.
	 self oop: objOop isLessThan: limit] whileTrue:
		[self assert: (self long64At: objOop) ~= 0.
		 nextObj := self objectAfter: objOop limit: endOfMemory.
		 aBlock value: objOop value: nextObj.
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := nextObj].
	self touch: prevPrevObj.
	self touch: prevObj