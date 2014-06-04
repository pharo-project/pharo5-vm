object enumeration
isEnumerableObjectNoAssert: objOop
	"Answer if objOop should be included in an allObjects...Do: enumeration.
	 This is for assert-checking only."
	| classIndex |
	classIndex := self classIndexOf: objOop.
	^classIndex >= self isForwardedObjectClassIndexPun
	  and: [classIndex < (numClassTablePages * self classTablePageSize)]