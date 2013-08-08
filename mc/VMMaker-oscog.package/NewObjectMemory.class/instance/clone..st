allocation
clone: obj
	"Return a shallow copy of the given object. May cause GC"
	"Assume: Oop is a real object, not a small integer.
	 Override to assert it's not a married context"
	self assert: ((self isContext: obj) not
				or: [(coInterpreter isMarriedOrWidowedContext: obj) not]). 
	^super clone: obj