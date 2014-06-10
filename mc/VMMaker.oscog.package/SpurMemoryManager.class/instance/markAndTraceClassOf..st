gc - global
markAndTraceClassOf: objOop
	"Ensure the class of the argument is marked, pushing it on the markStack if not already marked.
	 Also set the relevant bit in the classTableBitmap so that duplicate entries can be eliminated.
	 Note that this is recursive, but the metaclass chain should terminate quickly."
	<inline: false>
	| classIndex classObj |
	classIndex := self classIndexOf: objOop.
	self inClassTableBitmapSet: classIndex.
	classObj := self classOrNilAtIndex: classIndex.
	(self isMarked: classObj) ifFalse:
		[self setIsMarkedOf: classObj to: true.
		 self markAndTraceClassOf: classObj.
		 self push: classObj onObjStack: markStack]