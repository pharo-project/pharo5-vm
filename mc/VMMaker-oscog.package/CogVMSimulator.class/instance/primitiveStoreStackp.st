debugging traps
primitiveStoreStackp
	"self printContext: (self stackValue: 1).
	self halt."
	"(self stackValue: 1) = 16r1934F80 ifTrue: [self halt]."
	super primitiveStoreStackp