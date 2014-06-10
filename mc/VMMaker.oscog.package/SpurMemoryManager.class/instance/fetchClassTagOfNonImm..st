interpreter access
fetchClassTagOfNonImm: obj
	"In Spur an object's classIndex is the tag in all method caches."
	^self classIndexOf: obj