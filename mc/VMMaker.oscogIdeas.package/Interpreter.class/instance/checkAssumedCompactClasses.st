initialization
checkAssumedCompactClasses
	"Check that the classes the VM assumes are compact have the right indices."

	self checkCompactIndex: ClassBlockContextCompactIndex isClass: ClassBlockContext named: 'BlockContext'.
	self checkCompactIndex: ClassMethodContextCompactIndex isClass: ClassMethodContext named: 'MethodContext'