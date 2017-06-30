image segment in/out
return: errCode restoringObjectsIn: firstArray savedFirstFields: savedFirstFields and: secondArray savedHashes: savedHashes
	self leakCheckImageSegments ifTrue:
		[self halt: errCode printString].
	^super return: errCode restoringObjectsIn: firstArray savedFirstFields: savedFirstFields and: secondArray savedHashes: savedHashes