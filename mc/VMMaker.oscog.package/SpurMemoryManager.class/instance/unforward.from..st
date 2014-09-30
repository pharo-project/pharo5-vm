image segment in/out
unforward: obj1 from: obj2
	"Undo a forward: obj1 to: obj2 given that obj2 is a copy of obj1"
	self set: obj1 classIndexTo: (self classIndexOf: obj2) formatTo: (self formatOf: obj2).
	self storePointer: 0 ofForwarder: obj1 withValue: (self fetchPointer: 0 ofObject: obj2).
	(self rawNumSlotsOf: obj2) = 0 ifTrue:
		[self setRawNumSlotsOf: obj1 to: 0]