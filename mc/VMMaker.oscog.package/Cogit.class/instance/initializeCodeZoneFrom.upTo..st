initialization
initializeCodeZoneFrom: startAddress upTo: endAddress
	<api>
	self initializeBackend.
	backEnd stopsFrom: startAddress to: endAddress - 1.
	self cCode: [self sqMakeMemoryExecutableFrom: startAddress To: endAddress]
		inSmalltalk: [self initializeProcessor].
	codeBase := methodZoneBase := startAddress.
	minValidCallAddress := (codeBase min: coInterpreter interpretAddress)
								min: coInterpreter primitiveFailAddress.
	methodZone manageFrom: methodZoneBase to: endAddress.
	self maybeGenerateCheckFeatures.
	self maybeGenerateICacheFlush.
	self generateVMOwnerLockFunctions.
	ceGetSP := self cCoerceSimple: self genGetLeafCallStackPointer to: #'unsigned long (*)(void)'.
	self generateStackPointerCapture.
	self generateTrampolines.
	self computeEntryOffsets.
	self generateClosedPICPrototype.
	methodZone manageFrom: methodZoneBase to: endAddress.
	"N.B. this is assumed to be the last thing done in initialization; see Cogit>>initialized"
	self generateOpenPICPrototype