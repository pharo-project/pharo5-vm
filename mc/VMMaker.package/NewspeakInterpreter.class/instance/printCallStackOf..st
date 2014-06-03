debug printing
printCallStackOf: aContextOrProcess

	| ctxt home message methodSel |
	<inline: false>
	((self isContext: aContextOrProcess) not
	and: [(self lengthOf: aContextOrProcess) > MyListIndex
	and: [self isContext: (self fetchPointer: SuspendedContextIndex
									ofObject: aContextOrProcess)]]) ifTrue:
		[^self printCallStackOf: (self fetchPointer: SuspendedContextIndex
									ofObject: aContextOrProcess)].
	ctxt := aContextOrProcess.
	[ctxt = nilObj] whileFalse:
		[home := self findHomeForContext: ctxt.
		self printNum: ctxt.
		self space.
		self printActivationNameFor: (self fetchPointer: MethodIndex ofObject: home)
			receiver: (self fetchPointer: ReceiverIndex ofObject: home)
			isBlock: home ~= ctxt
			firstTemporary: (self fetchPointer: 0 + CtxtTempFrameStart ofObject: home).
		methodSel := self findSelectorOfMethod: (self fetchPointer: MethodIndex ofObject: home)
							forReceiver: (self fetchPointer: ReceiverIndex ofObject: home).
		methodSel = (self splObj: SelectorDoesNotUnderstand) ifTrue:
			"print arg message selector"
			[message := self fetchPointer: 0 + TempFrameStart ofObject: home.
			methodSel := self fetchPointer: MessageSelectorIndex ofObject: message.
			self print: ' '.
			self printStringOf: methodSel].
		 self cr.
		 ctxt := (self fetchPointer: SenderIndex ofObject: ctxt)]