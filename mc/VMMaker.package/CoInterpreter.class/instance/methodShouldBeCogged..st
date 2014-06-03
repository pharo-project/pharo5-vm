compiled methods
methodShouldBeCogged: aMethodObj
	<api>
	(self methodWithHeaderShouldBeCogged: (self headerOf: aMethodObj)) ifTrue:
		[^true].
	self maybeFlagMethodAsInterpreted: aMethodObj.
	^false