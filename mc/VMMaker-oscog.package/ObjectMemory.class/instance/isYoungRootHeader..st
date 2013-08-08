garbage collection
isYoungRootHeader: header
	"Answer if oop is a root for objects in youngSpace"
	^(header bitAnd: RootBit) ~= 0