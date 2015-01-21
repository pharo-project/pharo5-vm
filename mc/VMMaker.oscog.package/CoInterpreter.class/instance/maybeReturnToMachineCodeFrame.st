return bytecodes
maybeReturnToMachineCodeFrame
	"If the frame we're returning to is a machine code one, then return to it.
	 Otherwise, if it's an interpreter frame, load the saved ip."
	<inline: true>
	localIP asUnsignedInteger < objectMemory startOfMemory ifTrue:
		[localIP asUnsignedInteger ~= cogit ceReturnToInterpreterPC ifTrue:
			["localIP in the cog method zone indicates a return to machine code."
			 ^self returnToMachineCodeFrame].
		 localIP := self pointerForOop: (self iframeSavedIP: localFP)]