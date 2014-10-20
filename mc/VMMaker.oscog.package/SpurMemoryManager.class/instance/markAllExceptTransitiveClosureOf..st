image segment in/out
markAllExceptTransitiveClosureOf: arrayOfRoots
	"Mark all objects in the system except those in arrayOfRoots and objects only reachable from arrayOfRoots.
	 This is how the image segment writing primitive computes the set of objects to include in a segment."

 	self assert: self allObjectsUnmarked.
	self markObjectsIn: arrayOfRoots.
	self markObjects.
	self unmarkObjectsIn: arrayOfRoots.