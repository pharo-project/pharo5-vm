deflating
updateHashAt: here
	"Update the hash value at position here (one based)"
	^self updateHash: (zipCollection at: here)