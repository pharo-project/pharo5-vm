initialization
allocateBlockStarts: numBlocks
	"Allocate the structures used to manage block compilation.  This
	 needs to be a macro since the structures are alloca'ed (stack
	 allocated) to ensure their being freed when compilation is done."
	<cmacro: '(numBlocks) do { \
		blockStarts = (numBlocks) ? alloca(sizeof(BlockStart) * (numBlocks)) : 0; \
} while (0)'>
	blockStarts := numBlocks > 0 ifTrue:
					[CArrayAccessor on:
						((1 to: numBlocks) collect:
							[:ign| CogBlockStart new])]