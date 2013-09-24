initialization
allocateCounters
	"Allocate the structures used to manage counting conditional branch
	 compilation.  This  needs to be a macro since the structures are alloca'ed
	 (stack allocated) to ensure their being freed when compilation is done."
	<cmacro: '() do { \
		counters = numCounters ? alloca(sizeof(AbstractInstruction) * numCounters) : 0; \
} while (0)'>
	counters := CArrayAccessor on:
					((1 to: numCounters) collect:
						[:ign| backEnd class new])