array primitives
primitiveCompareBytes
	"Primitive. Compare two byte-indexed objects for equality"
	| arg1 arg2 len1 len2 |
	<export: true>
	argumentCount = 1 ifFalse:[^self primitiveFail].
	arg1 := self stackValue: 1.
	arg2 := self stackValue: 0.
	((self isBytes: arg1) and:[self isBytes: arg2]) 
		ifFalse:[^self primitiveFail].
	"Quick identity test"
	(arg1 == arg2) ifTrue:[^self pop: 2 thenPush: trueObj].
	len1 := self byteSizeOf: arg1.
	len2 := self byteSizeOf: arg2.
	len1 = len2 ifFalse:[^self pop: 2 thenPush: falseObj].
	0 to: len1-1 do:[:i|
		(self fetchByte: i ofObject: arg1) = (self fetchByte: i ofObject: arg2) 
			ifFalse:[^self pop: 2 thenPush: falseObj]].
	self pop: 2 thenPush: trueObj.
