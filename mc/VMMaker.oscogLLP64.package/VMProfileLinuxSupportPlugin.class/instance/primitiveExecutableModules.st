primitives
primitiveExecutableModules
	"Answer an Array of pairs of strings for executable modules (the VM executable and loaded libraries).
	 The first element in each pair is the filename of the module.  The second element is either nil or
	 the symlink's target, if the filename is a symlink."
	<export: true>
	| resultObj |
	numModules := 0.
	self cCode: 'dl_iterate_phdr(countnummodules,0)' inSmalltalk: [0].
	resultObj := interpreterProxy
					instantiateClass: interpreterProxy classArray
					indexableSize: numModules - 1 * 2. "skip the fake linux-gate.so.1"
	resultObj = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoMemory].
	interpreterProxy pushRemappableOop: resultObj.
	primErr := numModules := 0.
	self cCode: 'dl_iterate_phdr(reapmodulesymlinks,0)' inSmalltalk: [0].
	resultObj := interpreterProxy popRemappableOop.
	primErr ~= 0 ifTrue:
		[^interpreterProxy primitiveFailFor: primErr].
	^interpreterProxy methodReturnValue: resultObj