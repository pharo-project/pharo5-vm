bootstrap image
isOldObjABehavior: oldObj
	| oldObjClass oldObjClassClass |
	^(classToIndex includesKey: oldObj)
	or: [oldObjClass := oldHeap fetchClassOfNonImm: oldObj.
		oldObjClassClass := oldHeap fetchClassOfNonImm: oldObjClass.
		oldObjClass = classMetaclass
		or: [oldObjClassClass = classMetaclass]]