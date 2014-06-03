plugin primitive support
flushExternalPrimitiveOf: methodObj
	"methodObj is a CompiledMethod containing an external primitive. Flush the function address and session ID of the CM"
	| lit |
	(self literalCountOf: methodObj) > 0 ifFalse:
		[^nil]. "Something's broken"
	lit := self literal: 0 ofMethod: methodObj.
	((objectMemory isArray: lit) and:[(objectMemory lengthOf: lit) = 4]) ifFalse:
		[^nil]. "Something's broken"
	"ConstZero is a known SmallInt so no root check needed"
	objectMemory storePointerUnchecked: 2 ofObject: lit withValue: ConstZero.
	objectMemory storePointerUnchecked: 3 ofObject: lit withValue: ConstZero