debug support
objCouldBeClassObj: objOop
	"Answer if objOop looks like a class object.  WIth Spur be lenient if the object doesn't
	 yet have a hash (i.e. is not yet in the classTable), and accept forwarding pointers."
	<inline: false>
	| fieldOop |
	^(objectMemory isPointersNonImm: objOop)
	  and: [(objectMemory numSlotsOf: objOop) >= (InstanceSpecificationIndex+1)
	  and: [fieldOop := objectMemory fetchPointer: SuperclassIndex ofObject: objOop.
			((objectMemory isPointers: fieldOop)
			or: [(objectMemory rawHashBitsOf: objOop) = 0
				and: [(objectMemory isOopForwarded: fieldOop)
				and: [objectMemory isPointers: (objectMemory followForwarded: fieldOop)]]])
	  and: [fieldOop := objectMemory fetchPointer: MethodDictionaryIndex ofObject: objOop.
			((objectMemory isPointers: fieldOop)
			or: [(objectMemory rawHashBitsOf: objOop) = 0
				and: [(objectMemory isOopForwarded: fieldOop)
				and: [objectMemory isPointers: (objectMemory followForwarded: fieldOop)]]])
	  and: [(objectMemory isIntegerObject: (objectMemory fetchPointer: InstanceSpecificationIndex ofObject: objOop))]]]]