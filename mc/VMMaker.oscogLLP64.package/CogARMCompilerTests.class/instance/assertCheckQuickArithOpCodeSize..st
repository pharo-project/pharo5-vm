running
assertCheckQuickArithOpCodeSize: bytes
	"The problem is that there are negative value, which are not quick encodable in ARM"
	self assert: bytes <= 4