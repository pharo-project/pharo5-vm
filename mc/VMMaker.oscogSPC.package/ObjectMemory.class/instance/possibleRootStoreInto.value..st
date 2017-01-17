garbage collection
possibleRootStoreInto: oop value: valueObj 
	"oop is an old object. If valueObj is young, mark the object as a root."

	<inline: false>
	((self oop: valueObj isGreaterThanOrEqualTo: youngStart)
			and: [(self isIntegerObject: valueObj) not])
		ifTrue: ["Yes, valueObj is a young object"
				self noteAsRoot: oop headerLoc: oop]