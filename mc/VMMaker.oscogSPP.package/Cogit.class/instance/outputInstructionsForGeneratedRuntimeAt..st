initialization
outputInstructionsForGeneratedRuntimeAt: startAddress
	"Output instructions generated for one of the generated run-time routines, a trampoline, etc"
	| size endAddress |
	<inline: false>
	self computeMaximumSizes.
	methodLabel address: startAddress. "for addressIsInCurrentCompilation:"
	size := self generateInstructionsAt: startAddress.
	endAddress := self outputInstructionsAt: startAddress.
	self assert: startAddress + size = endAddress.
	methodZoneBase := self alignUptoRoutineBoundary: endAddress.
	backEnd stopsFrom: endAddress to: methodZoneBase - 1.
	self cCode: '' inSmalltalk: [methodZone freeStart: methodZoneBase].
	^startAddress