object enumeration
startOfMemory
	"Return the start of object memory. Use a macro so as not to punish the debug VM."
	<cmacro: '() GIV(memory)'>
	<returnTypeC: #usqInt>
	^memory