inline primitive generated code
lowcodePrimitiveStoreLocalInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"

	<var: #valueInt64 type: #'sqLong'>
	|valueInt64|
	BytesPerWord = 4 ifTrue: [
	self lowcodeStoreLocalInt64Workaround: extA in: localFP sp: localSP.
	] ifFalse: [
	valueInt64 := self internalPopStackInt64.
	stackPages int64AtPointer: (self framePointerOfNativeLocal: extA in: localFP) put: valueInt64.
	].
	extA := 0.


