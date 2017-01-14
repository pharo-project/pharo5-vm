testing - MiscPrimitivePlugin
testTranslateFromToTable
	"Verify that primitive exists in the VM"

	| s t |
	s := 'foo' copy. "copy so string is instantiated each time"
	t := ByteArray withAll: ((1 to: 255) as: ByteArray).
	self translate: s from: 1 to: 3 table: t.
	self assert: s = 'gpp'
