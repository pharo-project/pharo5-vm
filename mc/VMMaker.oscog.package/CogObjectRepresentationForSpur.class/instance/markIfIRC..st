newspeak support
markIfIRC: maybeIRCs
	"If maybeIRCs (from some cogMehtod's nextMethodOrIRCs) is in old space it is
	 a pointer to the first field of a pinned object in old space holding the implicit
	 receiver caches for a method.  If so, map it back to an oop and mark it."
	<var: #maybeIRCs type: #usqInt>
	<option: #NewspeakVM>
	<inline: true>
	(self oop: maybeIRCs isGreaterThan: objectMemory nilObject) ifTrue:
		[objectMemory markAndTrace: maybeIRCs - objectMemory baseHeaderSize]