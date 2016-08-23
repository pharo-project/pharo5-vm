testing - MiscPrimitivePlugin
testCompareWithCollated
	"Verify that primitive exists in the VM"

	self assert: 3 = (self compare: 'foo' with: 'bar' collated: ((0 to: 255) as: ByteArray))
