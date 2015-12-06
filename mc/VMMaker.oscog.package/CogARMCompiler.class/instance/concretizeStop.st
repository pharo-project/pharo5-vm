generate machine code - concretize
concretizeStop
	<inline: true>
	self machineCodeAt: 0 put: self stop.
	^machineCodeSize := 4