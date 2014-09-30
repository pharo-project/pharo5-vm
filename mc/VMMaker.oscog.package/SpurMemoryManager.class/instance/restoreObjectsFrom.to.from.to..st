image segment in/out
restoreObjectsFrom: firstIn to: lastIn from: firstSeg to: limitSeg
	"Unforward objects"
	| originalPtr originalObj copyPtr copyObj |
	originalPtr := firstIn.
	copyPtr := firstSeg.
	[self oop: originalPtr isLessThanOrEqualTo: lastIn] whileTrue:
		[originalObj := self longAt: originalPtr.
		 copyObj := self objectStartingAt: copyPtr.
		 self unforward: originalObj from: copyObj.
		 originalPtr := originalPtr + self bytesPerOop.
		 copyPtr := self addressAfter: copyObj].
	self assert: copyPtr = limitSeg