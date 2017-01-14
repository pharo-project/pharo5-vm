inline primitive generators generated code
genLowcodeCallArgumentInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"

	BytesPerWord = 4 ifTrue: [
	self ssNativeTop nativeStackPopToReg: TempReg secondReg: ReceiverResultReg.
	self ssNativePop: 1.
	self PushR: TempReg.
	self PushR: ReceiverResultReg.
	currentCallCleanUpSize := currentCallCleanUpSize + 8.
	] ifFalse: [
	self ssNativeTop nativeStackPopToReg: TempReg.
	self ssNativePop: 1.
	self PushR: TempReg.
	currentCallCleanUpSize := currentCallCleanUpSize + BytesPerWord.
	].

	^ 0

