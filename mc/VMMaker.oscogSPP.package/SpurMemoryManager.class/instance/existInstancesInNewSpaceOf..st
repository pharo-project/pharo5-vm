debug support
existInstancesInNewSpaceOf: classObj
	| classIndex |
	classIndex := self rawHashBitsOf: classObj.
	self allNewSpaceObjectsDo:
		[:obj|
		(self classIndexOf: obj) = classIndex ifTrue:
			[^true]].
	^false