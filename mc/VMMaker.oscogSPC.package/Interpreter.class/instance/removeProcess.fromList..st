process primitive support
removeProcess: aProcess fromList: aList 
	"Remove a given process from a linked list. May fail if aProcess is not on the list."
	| firstLink lastLink nextLink tempLink |
	firstLink := self fetchPointer: FirstLinkIndex ofObject: aList.
	lastLink := self fetchPointer: LastLinkIndex ofObject: aList.
	aProcess  == firstLink ifTrue:[
		nextLink := self fetchPointer: NextLinkIndex ofObject: aProcess .
		self storePointer: FirstLinkIndex ofObject: aList withValue: nextLink.
		aProcess  == lastLink ifTrue:[
			self storePointer: LastLinkIndex ofObject: aList withValue: self nilObject.
		].
	] ifFalse:[
		tempLink := firstLink.
		[tempLink == self nilObject ifTrue:[^self success: false]. "fail"
		nextLink := self fetchPointer: NextLinkIndex ofObject: tempLink.
		nextLink == aProcess] whileFalse:[
			tempLink := self fetchPointer: NextLinkIndex ofObject: tempLink.
		].
		nextLink := self fetchPointer: NextLinkIndex ofObject: aProcess.
		self storePointer: NextLinkIndex ofObject: tempLink withValue: nextLink.
		aProcess  == lastLink ifTrue:[
			self storePointer: LastLinkIndex ofObject: aList withValue: tempLink.
		].
	].
	self storePointer: NextLinkIndex ofObject: aProcess withValue: self nilObject.
