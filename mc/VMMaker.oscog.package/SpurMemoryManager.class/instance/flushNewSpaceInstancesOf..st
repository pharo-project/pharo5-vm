gc - scavenging
flushNewSpaceInstancesOf: aClass
	| classIndex |
	classIndex := self rawHashBitsOf: aClass.
	classIndex = 0 ifTrue: "no instances; nothing to do"
		[^self].
	scavenger tenuringClassIndex: classIndex.
	self scavengingGCTenuringIf: TenureByClass.
	self assert: (self existInstancesInNewSpaceOf: aClass) not