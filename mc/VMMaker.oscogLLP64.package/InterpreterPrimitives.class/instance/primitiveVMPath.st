system control primitives
primitiveVMPath
	"Return a string containing the path name of VM's directory."

	| s sz |
	sz := self vmPathSize.
	s := objectMemory instantiateClass: (objectMemory splObj: ClassByteString) indexableSize: sz.
	self vmPathGet: (s + objectMemory baseHeaderSize) Length: sz.
	self pop: 1 thenPush: s.
