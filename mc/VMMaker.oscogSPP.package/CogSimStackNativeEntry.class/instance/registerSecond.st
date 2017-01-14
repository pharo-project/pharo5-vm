accessing
registerSecond
	"Answer the value of register"
	self assert: type = SSRegisterPair.
	^ registerSecond