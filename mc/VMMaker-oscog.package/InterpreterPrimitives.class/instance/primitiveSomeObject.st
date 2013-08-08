object access primitives
primitiveSomeObject
	"Return the first object in the heap."

	self pop: argumentCount+1.
	self push: objectMemory firstAccessibleObject.