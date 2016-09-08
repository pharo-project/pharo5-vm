interpreter access
rawClassTagForClass: classObj
	"Answer the classObj's identityHash to use as a tag in a class comparison."
	^self rawHashBitsOf: classObj