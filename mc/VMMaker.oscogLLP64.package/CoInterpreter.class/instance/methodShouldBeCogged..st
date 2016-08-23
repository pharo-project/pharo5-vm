compiled methods
methodShouldBeCogged: aMethodObj
	<api>
	(self methodWithHeaderShouldBeCogged: (objectMemory methodHeaderOf: aMethodObj)) ifTrue:
		[^true].
	self maybeFlagMethodAsInterpreted: aMethodObj.
	^false