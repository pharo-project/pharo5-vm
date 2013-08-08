initialize-release
processor: aProcessor
	processor := aProcessor.
	guardedProcessorProtocol := aProcessor class selectors asSet.
	unguardedProcessorProtocol := #(#'Cog API' #opcodes #disassembly #printing)
										inject: Set new
										into: [ :protocol :category|
											protocol
												addAll: (aProcessor class organization listAtCategoryNamed: category);
												yourself].
	guardedProcessorProtocol removeAll: unguardedProcessorProtocol