page access
memIndexFor: byteAddress
	"Map an address into the stack zone into a word index into the slots in the stack zone."
	<doNotGenerate>
	^(self oopForPointer: byteAddress) - coInterpreter stackZoneBase - 1 // objectMemory wordSize + 1