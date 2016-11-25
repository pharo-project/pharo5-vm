accessing
register
	"Answer the value of register"
	self assert: (type = SSBaseOffset or: [type = SSRegister or: [type = SSSpill]]).
	^register