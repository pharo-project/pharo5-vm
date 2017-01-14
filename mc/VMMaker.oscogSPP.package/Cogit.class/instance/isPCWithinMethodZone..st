disassembly
isPCWithinMethodZone: address
	<api>
	<var: #address type: #'void *'>
	^address asUnsignedInteger
		between: methodZoneBase
		and: methodZone freeStart