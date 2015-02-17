type inference
typeForArithmetic: sendNode in: aTMethod
	"Answer the return type for an arithmetic sendThis is so that the inliner can still
	 inline simple expressions.  Deal with pointer arithmetic and floating point arithmetic"
	(self typeFor: sendNode args first in: aTMethod) = #double ifTrue:
		[^#double].
	^self typeFor: sendNode receiver in: aTMethod