initialization
genStoreHeader: header intoNewInstance: rcvrReg using: scratchReg
	"Generate the instructions to move the constant header into a new instance pointed to by rcvrReg."
	<inline: true>
	self subclassResponsibility