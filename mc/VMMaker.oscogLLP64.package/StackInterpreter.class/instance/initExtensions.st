simulation support
initExtensions
	<inline: true>
	self cppIf: MULTIPLEBYTECODESETS ifTrue: [extA := extB := 0]