garbage collection
isYoungRoot: oop
	"Answer if oop is a root for objects in youngSpace"
	^self isYoungRootHeader: (self baseHeader: oop)