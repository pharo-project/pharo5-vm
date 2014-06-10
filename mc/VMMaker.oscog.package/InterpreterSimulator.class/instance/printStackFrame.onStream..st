debug support
printStackFrame: ctxt onStream: strm
	| classAndSel home |
	home := (self fetchClassOf: ctxt) = (self splObj: ClassBlockContext)
		ifTrue: [self fetchPointer: HomeIndex ofObject: ctxt]
		ifFalse: [ctxt].
	classAndSel := self
		classAndSelectorOfMethod: (self fetchPointer: MethodIndex ofObject: home)
		forReceiver: (self fetchPointer: ReceiverIndex ofObject: home).
	strm cr; nextPutAll: ctxt hex8.
	ctxt = home ifFalse: [strm nextPutAll: ' [] in'].
	strm space; nextPutAll: (self nameOfClass: classAndSel first).
	strm nextPutAll: '>>'; nextPutAll: (self shortPrint: classAndSel last).
