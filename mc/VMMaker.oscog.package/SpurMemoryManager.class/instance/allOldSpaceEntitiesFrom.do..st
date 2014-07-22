object enumeration
allOldSpaceEntitiesFrom: initialObject do: aBlock
	<inline: true>
	| prevObj prevPrevObj objOop |
	self assert: (self isOldObject: initialObject).
	prevPrevObj := prevObj := nil.
	objOop := initialObject.
	[self assert: objOop \\ self allocationUnit = 0.
	 self oop: objOop isLessThan: endOfMemory] whileTrue:
		[self assert: (self long64At: objOop) ~= 0.
		 aBlock value: objOop.
		 prevPrevObj := prevObj.
		 prevObj := objOop.
		 objOop := self objectAfter: objOop limit: endOfMemory].
	self touch: prevPrevObj.
	self touch: prevObj