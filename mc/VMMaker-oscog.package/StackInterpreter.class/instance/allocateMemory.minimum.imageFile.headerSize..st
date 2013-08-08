image save/restore
allocateMemory: heapSize minimum: minimumMemory imageFile: fileStream headerSize: headerSize
	"Translate to C function call with (case sensitive) camelCase. The purpose of this
	 method is to document the translation.
	 The default implementation is sqAllocateMemory(minimumMemory, heapSize). This may
	 be redefined to make use of the image file and header size parameters for efficient
	 implementation with mmap().
	 See CCodeGenerator>>writeDefaultMacrosOn: which specifies a default implementation."

	<inline: true>
	<returnTypeC: #'char *'>
	<var: #fileStream type: #sqImageFile>
	^self pointerForOop: (self
							allocateMemory: heapSize
							Minimum: minimumMemory
							ImageFile: fileStream
							HeaderSize: headerSize)