object access primitives
primitiveObjectAt
	"self transcript
		nextPutAll: (self nameOfClass: (self methodClassOf: (self stackValue: 1)));
		nextPutAll: '>>#';
		nextPutAll: (self stringOf: (self maybeSelectorOfMethod: (self stackValue: 1)));
		nextPutAll: ' objectAt: '; print: (objectMemory integerValueOf: self stackTop); cr; flush.
	self halt."
	^super primitiveObjectAt