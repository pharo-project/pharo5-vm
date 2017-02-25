inline primitive support
lowcodeStoreLocalInt64Workaround: baseOffset in: theFP sp: theSP
	"This method is a workaround a GCC bug"
	<inline: #never>
	<option: #LowcodeVM>
	<var: #theFP type: #'char*'>
	<var: #theSP type: #'char*'>
	<var: #value type: #'sqLong'>
	| value workNativeSP|

	"Fetch the value from the native tack"
	workNativeSP := (self nativeStackPointerIn: theFP).
	value := stackPages long64AtPointer: (workNativeSP - 1).
	self nativeStackPointerIn: theFP put: workNativeSP + 8.

	"Store the local"
 	self int64AtPointer: (self framePointerOfNativeLocal: baseOffset in: theFP) put: value.