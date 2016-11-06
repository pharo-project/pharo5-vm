object access
oldRawNumSlotsOf: objOop
	<returnTypeC: #usqInt>
	<inline: true>
	^(self longAt: objOop) asUnsignedInteger >> self numSlotsFullShift