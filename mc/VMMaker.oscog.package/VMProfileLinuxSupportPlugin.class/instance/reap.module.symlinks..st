iteration callbacks
reap: info module: size symlinks: ignored
	"like reap:module:names:, but follows symlinks"
	<returnTypeC: #int>
	| elfModuleName len moduleNameObj GetAttributeString symLinkBuf |
	<var: #info type: #'struct dl_phdr_info *'>
	<var: 'elfModuleName' type: #'const char *'>
	<var: #GetAttributeString declareC: 'extern char *GetAttributeString(sqInt)'>
	<var: #symLinkBuf declareC: 'char symLinkBuf[PATH_MAX]'>
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
	"now dereference the symlink, if it exists"
	self str: symLinkBuf cpy: elfModuleName.
	(len := self read: elfModuleName li: symLinkBuf nk: #'PATH_MAX') > 0
		ifTrue:
			[moduleNameObj := interpreterProxy
									instantiateClass: interpreterProxy classString
									indexableSize: len.
			 moduleNameObj = 0 ifTrue:
				[primErr := PrimErrNoMemory.
				 ^1]. "stop iteration"
			 self st: (interpreterProxy arrayValueOf: moduleNameObj)
				rn: symLinkBuf
				cpy: len. "(char *)strncpy()"
			 interpreterProxy
				storePointer: numModules + 1
				ofObject: interpreterProxy topRemappableOop
				withValue: moduleNameObj]
		ifFalse:
			[interpreterProxy
				storePointer: numModules + 1
				ofObject: interpreterProxy topRemappableOop
				withValue: interpreterProxy nilObject].
	numModules := numModules + 2.
	^0