bytecode generator support
reinitializeOpcodesFrom: start to: end
	<inline: true>
	start to: end do:
		[:i|
		(self abstractInstructionAt: i) reinitializeOpcode]