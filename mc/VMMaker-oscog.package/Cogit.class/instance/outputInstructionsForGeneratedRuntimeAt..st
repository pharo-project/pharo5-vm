initialization
outputInstructionsForGeneratedRuntimeAt: startAddress
	"Output instructions generated for one of the generated run-time routines, a trampoline, etc"
	| size endAddress |
	<inline: false>
	self computeMaximumSizes.
	size := self generateInstructionsAt: startAddress.
	endAddress := self outputInstructionsAt: startAddress.
	self assert: startAddress + size = endAddress.
	methodZoneBase := self alignUptoRoutineBoundary: endAddress.
	backEnd nopsFrom: endAddress to: methodZoneBase - 1.
	self cCode: '' inSmalltalk: [methodZone freeStart: methodZoneBase].
	^startAddress