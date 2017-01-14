test support
dataRegistersWithAccessorsExcept: accessorsToExclude do: aTrinaryBlock
	self registers withIndexDo:
		[:reg :i| | getter setter |
		getter := #(eax ecx edx ebx esp ebp esi edi) at: i.
		setter := #(eax: ecx: edx: ebx: esp: ebp: esi: edi:) at: i.
		(accessorsToExclude includes: getter) ifFalse:
			[aTrinaryBlock value: reg value: getter value: setter]]