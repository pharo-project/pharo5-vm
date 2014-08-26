bootstrap image
isOldObjABehavior: oldObj
	| oldObjClass |
	^(classToIndex includesKey: oldObj)
	or: [(oldObjClass := oldHeap fetchClassOfNonImm: oldObj) = self classMetaclass
	or: [(oldHeap fetchClassOfNonImm: oldObjClass) = classMetaclass]]