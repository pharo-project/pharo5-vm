accessing
registerAt: index 
	^self perform: (#(eax ecx edx ebx esp ebp esi edi) at: index + 1)