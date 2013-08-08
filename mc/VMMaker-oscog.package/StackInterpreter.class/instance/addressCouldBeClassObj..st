debug support
addressCouldBeClassObj: maybeClassObj
	"Answer if maybeClassObj looks like a class object"
	<inline: false>
	^(objectMemory addressCouldBeObj: maybeClassObj)
	  and: [((objectMemory isPointersNonInt: maybeClassObj) and: [(objectMemory lengthOf: maybeClassObj) >= 3])
	  and: [(objectMemory isPointersNonInt: (objectMemory fetchPointer: SuperclassIndex ofObject: maybeClassObj))
	  and: [(objectMemory isPointersNonInt: (objectMemory fetchPointer: MethodDictionaryIndex ofObject: maybeClassObj))
	  and: [(objectMemory isIntegerObject: (objectMemory fetchPointer: InstanceSpecificationIndex ofObject: maybeClassObj))]]]]