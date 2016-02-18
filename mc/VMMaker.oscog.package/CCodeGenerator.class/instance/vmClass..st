accessing
vmClass: aClass
	"Set the main translation class if any.  This is nil other than for the core VM.
	 It may be an interpreter or a cogit"
	vmClass := aClass.
	vmClass ifNotNil:
		[generateDeadCode := vmClass shouldGenerateDeadCode]