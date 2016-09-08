accessing
register
	<doNotGenerate>
	"Answer the value of register"
	self assert: ((([type = SSNativeRegister] or: [type = SSRegisterPair]) or: [type = SSRegisterSingleFloat]) or: [type = SSRegisterDoubleFloat]).
	^register