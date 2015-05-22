initialization
initStackPagesAndInterpret
	"Initialize the stack pages and enter interpret. Use alloca'ed memory so that when
	 we have a JIT its stack pointer will be on the native stack since alloca allocates
	 memory on the stack. Certain thread systems use the native stack pointer as the
	 frame ID so putting the stack anywhere else can confuse the thread system."

	"Override to establish the setjmp/longjmp handler for reentering the interpreter
	 from machine code, and disable executablity on the heap and stack pages."

	"This should be in its own initStackPages method but Slang can't inline
	 C code strings."
	| stackPageBytes stackPagesBytes theStackMemory |
	<var: #theStackMemory type: #'char *'>
	stackPageBytes := self stackPageByteSize.
	stackPagesBytes := self computeStackZoneSize.
	theStackMemory := self
							cCode: [self alloca: stackPagesBytes]
							inSmalltalk: [stackPages initializeWithByteSize: stackPagesBytes for: self].
	self cCode: [self me: theStackMemory ms: 0 et: stackPagesBytes].
	self sqMakeMemoryNotExecutableFrom: objectMemory startOfMemory asUnsignedInteger
		To: objectMemory memoryLimit asUnsignedInteger.
	self sqMakeMemoryNotExecutableFrom: theStackMemory asUnsignedInteger
		To: theStackMemory asUnsignedInteger + stackPagesBytes.
	stackPages
		initializeStack: theStackMemory
		numSlots: stackPagesBytes / objectMemory wordSize
		pageSize: stackPageBytes / objectMemory wordSize.
	self assert: self minimumUnusedHeadroom = stackPageBytes.

	"Once the stack pages are initialized we can continue to bootstrap the system."
	self loadInitialContext.
	"We're ready for the heartbeat (poll interrupt)"
	self ioInitHeartbeat.
	self initialEnterSmalltalkExecutive.
	^nil