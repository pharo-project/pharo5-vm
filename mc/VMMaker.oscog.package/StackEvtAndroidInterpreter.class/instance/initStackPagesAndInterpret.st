process primitive support
initStackPagesAndInterpret
	"Initialize the stack pages and enter interpret. Use alloca'ed memory so that when
	 we have a JIT its stack pointer will be on the native stack since alloca allocates
	 memory on the stack. Certain thread systems use the native stack pointer as the
	 frame ID so putting the stack anywhere else can confuse the thread system."
	
	"This method overrides its parent so that heartbeat is not initialized: EventVM does not
	have hartbeat."
	
	"This method overrides its parent so that stack pages are malloc-ed rather than
	alloca-ed so they are retained intact when interpreter exits to wait for an event."

	"This should be in its own initStackPages method but Slang can't inline
	 C code strings."
	| stackPageBytes stackPagesBytes theStackMemory |
	<var: #theStackMemory type: #'void *'>
	stackPageBytes := self stackPageByteSize.
	stackPagesBytes := self computeStackZoneSize.
	theStackMemory := self
						cCode: 'malloc(stackPagesBytes)'
						inSmalltalk:
							[stackPages := self stackPagesClass new.
							 stackPages initializeWithByteSize: stackPagesBytes for: self].
	stackPages
		initializeStack: theStackMemory
		numSlots: stackPagesBytes / BytesPerWord
		pageSize: stackPageBytes / BytesPerWord
		stackLimitOffset: self stackLimitOffset
		stackPageHeadroom: self stackPageHeadroom.

	"Once the stack pages are initialized we can continue to bootstrap the system."
	self loadInitialContext.
	self interpret.
	^nil