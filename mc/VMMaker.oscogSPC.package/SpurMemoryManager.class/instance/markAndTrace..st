gc - global
markAndTrace: objOop
	"Mark the argument, and all objects reachable from it, and any remaining objects
	 on the mark stack. Follow forwarding pointers in the scan."
	<api>
	<inline: #never>
	"if markAndTrace: is to follow and eliminate forwarding pointers
	 in its scan it cannot be handed an r-value which is forwarded.
	 The assert for this is in markAndShouldScan:"
	(self markAndShouldScan: objOop) ifFalse:
		[^self].

	"Now scan the object, and any remaining objects on the mark stack."
	self markLoopFrom: objOop