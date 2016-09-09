initialization
setupNativeStack
	<option: #LowcodeVM>
	<var: #theNativeStackMemory type: #'char*'>
	<var: #theShadowCallStackMemory type: #'char*'>
	<inline: false>
	"This initializes an alternate stack that is used by the Lowcode instructions"
	| nativeStackMemorySize theNativeStackMemory shadowCallStackMemorySize theShadowCallStackMemory|
	nativeStackMemorySize := self nativeStackSize.
	theNativeStackMemory := self
							cCode: [self malloc: nativeStackMemorySize ]
							inSmalltalk: [CArrayAccessor on: (ByteArray new: self nativeStackSize)].
	nativeStackPointer := theNativeStackMemory + nativeStackMemorySize.
	
	shadowCallStackMemorySize := self shadowCallStackSize.
	theShadowCallStackMemory := self
							cCode: [self malloc: shadowCallStackMemorySize ]
							inSmalltalk: [CArrayAccessor on: (ByteArray new: self shadowCallStackSize)].
	shadowCallStackPointer := theShadowCallStackMemory + shadowCallStackMemorySize.