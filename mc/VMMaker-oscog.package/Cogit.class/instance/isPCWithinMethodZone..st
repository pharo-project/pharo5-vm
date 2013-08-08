disassembly
isPCWithinMethodZone: address
	<api>
	<var: #address type: #'char *'>
	^address asUnsignedInteger
		between: methodZoneBase
		and: methodZone freeStart