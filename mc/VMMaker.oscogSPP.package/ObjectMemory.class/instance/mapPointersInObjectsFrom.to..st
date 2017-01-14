gc -- compaction
mapPointersInObjectsFrom: memStart to: memEnd
	"Use the forwarding table to update the pointers of all non-free objects in the given range of memory.
	 Also remap pointers in root objects which may contains pointers into the given memory range, and
	 don't forget to flush the method cache based on the range."
	<inline: false>
	(self shouldRemapObj: nilObj) ifTrue:
		[nilObj := self remapObj: nilObj].
	(self shouldRemapObj: falseObj) ifTrue:
		[falseObj := self remapObj: falseObj].
	(self shouldRemapObj: trueObj) ifTrue:
		[trueObj := self remapObj: trueObj].
	(self shouldRemapObj: specialObjectsOop) ifTrue:
		[specialObjectsOop := self remapObj: specialObjectsOop].
	"update interpreter variables"
	self
		mapInterpreterOops;
		flushMethodCacheFrom: memStart to: memEnd.
	self remapRemapBufferAndExtraRoots.
	self updatePointersInRootObjectsFrom: memStart to: memEnd.
	self updatePointersInRangeFrom: memStart to: memEnd.
