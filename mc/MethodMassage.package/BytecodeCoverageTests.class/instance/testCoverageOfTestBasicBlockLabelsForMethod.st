tests
testCoverageOfTestBasicBlockLabelsForMethod
	"[| me |
	me := self new.
	[me setUp; testCoverageOfTestBasicBlockLabelsForMethod]
		ensure: [me tearDown]] timeToRun"
	"[| me |
	me := self new.
	[me setUp; coverTestBasicBlockLabelsForMethod]
		ensure: [me tearDown]] timeToRun"
	| theMethod |
	theMethod := self class >> #testBasicBlockLabelsFor:.
	BytecodeCoverer new coverMethod: theMethod.
	self assert: (theMethod propertyValueAt: #coverage) notNil.
	self assert: (theMethod propertyValueAt: #coverage) notEmpty.

	self coverTestBasicBlockLabelsForMethod.

	self assert: ((theMethod) propertyValueAt: #coverage) isEmpty