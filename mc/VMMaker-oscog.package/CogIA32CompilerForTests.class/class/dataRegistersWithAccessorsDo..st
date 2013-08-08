test support
dataRegistersWithAccessorsDo: aTrinaryBlock
	self registers withIndexDo:
		[:reg :i|
		aTrinaryBlock
			value: reg
			value: (#(eax ecx edx ebx esp ebp esi edi) at: i)
			value: (#(eax: ecx: edx: ebx: esp: ebp: esi: edi:) at: i)]