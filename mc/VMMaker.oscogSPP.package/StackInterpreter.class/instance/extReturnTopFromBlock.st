return bytecodes
extReturnTopFromBlock
	"218		11011010		Return Stack Top From Block [* return from enclosing block N, N = Extend A]
	 If extA is zero, return to the caller of the current block activation.
	 If extA is non-zero return to the caller of the Nth enclosing block activation."
	extA = 0 ifTrue:
		[localReturnValue := self internalStackTop.
		 ^self commonCallerReturn].
	self shouldBeImplemented.
	extA := 0