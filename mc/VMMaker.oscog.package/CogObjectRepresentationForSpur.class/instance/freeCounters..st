sista support
freeCounters: theCounters
	<var: #theCounters type: #usqInt>
	<inline: true>
	<option: #SistaStackToRegisterMappingCogit>
	theCounters ~= 0 ifTrue:
		[objectMemory freeObject: theCounters - objectMemory baseHeaderSize]