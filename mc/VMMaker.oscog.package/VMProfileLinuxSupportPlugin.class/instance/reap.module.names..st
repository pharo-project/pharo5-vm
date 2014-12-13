iteration callbacks
reap: info module: size names: ignored
	<returnTypeC: #int>
	| elfModuleName len moduleNameObj GetAttributeString |
	<var: #info type: #'struct dl_phdr_info *'>
	<var: 'elfModuleName' type: #'const char *'>
	<var: #GetAttributeString declareC: 'extern char *GetAttributeString(sqInt)'>
	<var: #size type: #'size_t'>
	<var: #ignored type: #'void *'>
	self touch: GetAttributeString.
	elfModuleName := self cCode: 'numModules ? info->dlpi_name : GetAttributeString(0)'.
	(elfModuleName isNil
	 or: [(len := self strlen: elfModuleName) = 0]) ifTrue:
		[^0]. "skip the fake linux-gate.so.1"
	moduleNameObj := interpreterProxy
							instantiateClass: interpreterProxy classString
							indexableSize: len.
	moduleNameObj = 0 ifTrue:
		[primErr := PrimErrNoMemory.
		 ^1]. "stop iteration"
	self st: (interpreterProxy arrayValueOf: moduleNameObj)
		rn: elfModuleName
		cpy: len. "(char *)strncpy()"
	interpreterProxy
		storePointer: numModules
		ofObject: interpreterProxy topRemappableOop
		withValue: moduleNameObj.
	numModules := numModules + 1.
	^0