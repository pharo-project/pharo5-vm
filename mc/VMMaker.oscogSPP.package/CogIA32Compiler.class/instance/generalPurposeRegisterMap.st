disassembly
generalPurposeRegisterMap
	<doNotGenerate>
	"Answer a Dictionary from register getter to register index."
	^Dictionary newFromPairs:
		{	#eax. EAX.
			#ecx. ECX.
			#edx. EDX.
			#ebx. EBX.
			#esi.  ESI.
			#edi.  EDI	}