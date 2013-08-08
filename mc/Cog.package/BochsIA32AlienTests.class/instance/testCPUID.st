tests
testCPUID
	| vendorString |
	self processor
			eip: 0;
			eax: 0. "get vendor identfication string"
	self processor singleStepIn: (ByteArray with: 16r0F with: 16rA2 with: 16r90) "cpuid;nop".
	self assert: self processor eip = 2.
	self assert: self processor eax ~= 0.
	vendorString := (ByteArray new: 12)
						longAt: 1 put: self processor ebx bigEndian: false;
						longAt: 5 put: self processor edx bigEndian: false;
						longAt: 9 put: self processor ecx bigEndian: false;
						asString.
	self assert: (vendorString = 'GenuineIntel'
				or: [vendorString = 'AuthenticAMD'])