gc - global
markAndTraceClassOf: objOop
	"Ensure the class of the argument is marked, pushing it on the markStack if not already marked.
	 And for one-way become, which can create duplicate entries in the class table, make sure
	 objOop's classIndex refers to the classObj's actual classIndex.
	 Note that this is recursive, but the metaclass chain should terminate quickly."
	<inline: false>
	| classIndex classObj realClassIndex |
	classIndex := self classIndexOf: objOop.
	classObj := self classOrNilAtIndex: classIndex.
	self assert: (coInterpreter objCouldBeClassObj: classObj).
	realClassIndex := self rawHashBitsOf: classObj.
	(classIndex ~= realClassIndex
	 and: [classIndex > self lastClassIndexPun]) ifTrue:
		[self setClassIndexOf: objOop to: realClassIndex].
	(self isMarked: classObj) ifFalse:
		[self setIsMarkedOf: classObj to: true.
		 self markAndTraceClassOf: classObj.
		 self push: classObj onObjStack: markStack]