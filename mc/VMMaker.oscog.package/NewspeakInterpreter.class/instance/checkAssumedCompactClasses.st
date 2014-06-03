initialization
checkAssumedCompactClasses
	"Check that the classes the VM assumes are compact have the right indices.
	 As of 5/10/2011 Newspeak images have Squeak V9 compact classes.  If and
	 when we bootstrap to Cog , Squeak V4 and closures we can use the fuller set
	 for faster large integer arithmetic, etc."
	self checkCompactIndex: ClassArrayCompactIndex isClass: ClassArray named: 'Array'.
	self checkCompactIndex: ClassLargePositiveIntegerCompactIndex isClass: ClassLargePositiveInteger named: 'LargePositiveInteger'.
	self checkCompactIndex: ClassFloatCompactIndex isClass: ClassFloat named: 'Float'.
	self checkCompactIndex: ClassBlockContextCompactIndex isClass: ClassBlockContext named: 'BlockContext'.
	self checkCompactIndex: ClassMethodContextCompactIndex isClass: ClassMethodContext named: 'MethodContext'