common selector sends
bytecodePrimAtPut
	"Override to eliminate the atCache, something of little benefit to the JIT."
	messageSelector := self specialSelector: 17.
	argumentCount := 2.
	self normalSend