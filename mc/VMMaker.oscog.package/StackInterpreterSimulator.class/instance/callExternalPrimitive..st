plugin support
callExternalPrimitive: mapIndex
	| entry |
	entry := self pluginEntryFor: mapIndex.
	"Spur needs the primitiveFunctionPointer to be set correctly
	 for accurate following of forwarders on primitive failure."
	objectMemory hasSpurMemoryManagerAPI ifTrue:
		[primitiveFunctionPointer := entry at: 2].
	^(entry at: 1) perform: (entry at: 2)