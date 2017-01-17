common selector sends
bytecodePrimAt
	"Override to eliminate the atCache, something of little benefit to the JIT."
	messageSelector := self specialSelector: 16.
	argumentCount := 1.
	self normalSend