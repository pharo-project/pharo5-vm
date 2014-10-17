initialize-release
processor: aProcessor
	processor := aProcessor.
	guardedProcessorProtocol := aProcessor class selectors asSet
									addAll: aProcessor class superclass selectors;
									yourself.
	unguardedProcessorProtocol := #(#'Cog API' #opcodes #disassembly #printing)
										inject: Set new
										into: [ :protocol :category|
											protocol
												addAll: (aProcessor class organization listAtCategoryNamed: category);
												addAll: (aProcessor class superclass organization listAtCategoryNamed: category);
												yourself].
	guardedProcessorProtocol removeAll: unguardedProcessorProtocol