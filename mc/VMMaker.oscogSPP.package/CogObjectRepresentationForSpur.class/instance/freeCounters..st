sista support
freeCounters: theCounters
	<var: #theCounters type: #usqInt>
	<inline: true>
	<option: #SistaCogit>
	theCounters ~= 0 ifTrue:
		[objectMemory freeObject: theCounters - objectMemory baseHeaderSize]