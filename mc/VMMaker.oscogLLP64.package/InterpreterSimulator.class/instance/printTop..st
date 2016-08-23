debug support
printTop: n
	"Print important fields of the top n contexts"
	| ctxt classAndSel home top ip sp |
	ctxt := activeContext.
	^ String streamContents:
		[:strm | 1 to: n do:
			[:i |
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
			ctxt = activeContext
				ifTrue: [ip := instructionPointer - method - (self baseHeaderSize - 2).
						sp := self stackPointerIndex - TempFrameStart + 1.
						top := self stackTop]
				ifFalse: [ip := self integerValueOf:
							(self fetchPointer: InstructionPointerIndex ofObject: ctxt).
						sp := self integerValueOf:
							(self fetchPointer: StackPointerIndex ofObject: ctxt).
						top := self longAt: ctxt + (self lastPointerOf: ctxt)].
			strm cr; tab; nextPutAll: 'ip = '; print: ip.
			strm cr; tab; nextPutAll: 'sp = '; print: sp.
			strm cr; tab; nextPutAll: 'top = '; nextPutAll: (self shortPrint: top).
			(ctxt := (self fetchPointer: SenderIndex ofObject: ctxt)) = nilObj
				ifTrue: [^strm contents].
			].
		]