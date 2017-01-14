newspeak support
freeIRCs: maybeIRCs
	<var: #maybeIRCs type: #usqInt>
	<option: #NewspeakVM>
	<inline: true>
	(self oop: maybeIRCs isGreaterThan: objectMemory nilObject) ifTrue:
		[objectMemory freeObject: maybeIRCs - objectMemory baseHeaderSize]