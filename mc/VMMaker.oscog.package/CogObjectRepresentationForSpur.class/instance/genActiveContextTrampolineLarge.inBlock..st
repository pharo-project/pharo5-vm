initialization
genActiveContextTrampolineLarge: isLarge inBlock: isBlock
	"Create a trampoline to answer the active context that will
	 answer it if a frame is already married, and create it otherwise.
	 Assume numArgs is in SendNumArgsReg."
	self subclassResponsibility