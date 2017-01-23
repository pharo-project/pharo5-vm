initialization
initializeCodeZoneFrom: startAddress upTo: endAddress
	<api>
	self initializeBackend.
	backEnd stopsFrom: startAddress to: endAddress - 1.
	self cCode: [self sqMakeMemoryExecutableFrom: startAddress To: endAddress]
		inSmalltalk:
			[startAddress = self class guardPageSize ifTrue:
				[backEnd stopsFrom: 0 to: endAddress - 1].
			 self initializeProcessor].
	codeBase := methodZoneBase := startAddress.
	minValidCallAddress := (codeBase min: coInterpreter interpretAddress)
								min: coInterpreter primitiveFailAddress.
	methodZone manageFrom: methodZoneBase to: endAddress.
	self maybeGenerateCheckFeatures.
	self maybeGenerateICacheFlush.
	self generateVMOwnerLockFunctions.
	self genGetLeafCallStackPointer.
	self generateStackPointerCapture.
	self generateTrampolines.
	self computeEntryOffsets.
	self computeFullBlockEntryOffsets.
	self generateClosedPICPrototype.
	"repeat so that now the methodZone ignores the generated run-time"
	methodZone manageFrom: methodZoneBase to: endAddress.
	"N.B. this is assumed to be the last thing done in initialization; see Cogit>>initialized"
	self generateOpenPICPrototype