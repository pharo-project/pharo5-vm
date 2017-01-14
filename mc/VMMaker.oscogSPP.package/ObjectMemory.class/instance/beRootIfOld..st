garbage collection
beRootIfOld: oop 
	"If this object is old, mark it as a root (because a new object 
	may be stored into it)"
	<api>
	<inline: false>
	((self oop: oop isLessThan: youngStart)
			and: [(self isIntegerObject: oop) not])
		ifTrue: ["Yes, oop is an old object"
			self noteAsRoot: oop headerLoc: oop]