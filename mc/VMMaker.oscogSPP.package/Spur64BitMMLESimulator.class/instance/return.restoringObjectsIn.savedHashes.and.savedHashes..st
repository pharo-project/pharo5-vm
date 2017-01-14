image segment in/out
return: errCode restoringObjectsIn: firstArray savedHashes: firstSavedHashes and: secondArray savedHashes: secondSavedHashes
	self leakCheckImageSegments ifTrue:
		[self halt: errCode printString].
	^super return: errCode restoringObjectsIn: firstArray savedHashes: firstSavedHashes and: secondArray savedHashes: secondSavedHashes