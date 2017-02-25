object access primitives
primitiveStoreStackp
	"self printContext: (self stackValue: 1).
	self halt."
	super primitiveStoreStackp.
	"self printContext: self stackTop"