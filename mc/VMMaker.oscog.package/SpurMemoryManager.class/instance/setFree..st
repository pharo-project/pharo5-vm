free space
setFree: objOop
	<inline: true>
	"turn the object into a free chunk, zeroing classIndex, format, isGrey,isPinned,isRemembered,isImmutable & ?."
	self long32At: objOop put: 0