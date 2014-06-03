indexing primitives
primitiveCompareBytes
	"Primitive. Compare two byte-indexed objects for equality"
	| arg1 arg2 len1 len2 |
	<export: true>
	argumentCount = 1 ifFalse:[self primitiveFail. ^self].
	arg1 := self stackValue: 1.
	arg2 := self stackValue: 0.
	((objectMemory isBytes: arg1) and:[objectMemory isBytes: arg2]) 
		ifFalse:[self primitiveFail. ^self].
	"Quick identity test"
	(arg1 = arg2) ifTrue:[^self pop: 2 thenPush: objectMemory trueObject].
	len1 := objectMemory byteSizeOf: arg1.
	len2 := objectMemory byteSizeOf: arg2.
	len1 = len2 ifFalse:[^self pop: 2 thenPush: objectMemory falseObject].
	0 to: len1-1 do:[:i|
		(objectMemory fetchByte: i ofObject: arg1) = (objectMemory fetchByte: i ofObject: arg2) 
			ifFalse:[^self pop: 2 thenPush: objectMemory falseObject]].
	self pop: 2 thenPush: objectMemory trueObject.
