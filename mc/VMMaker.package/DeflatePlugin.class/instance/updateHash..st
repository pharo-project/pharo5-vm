deflating
updateHash: nextValue
	"Update the running hash value based on the next input byte.
	Return the new updated hash value."
	^((zipHashValue << DeflateHashShift) bitXor: nextValue) bitAnd: DeflateHashMask.