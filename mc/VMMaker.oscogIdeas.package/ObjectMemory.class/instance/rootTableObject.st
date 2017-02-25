primitive support
rootTableObject
	"Answer an object containing the contents of the rootTable for primitiveRootTable.
	 The allocation can cause a GC itself and if so the return value may be inaccurate
	 - in this case one should guard the read operation by looking at the gc counter statistics."
	| tableObj sz j |
	sz := rootTableCount.
	tableObj := self instantiateClass: self classArray indexableSize: sz. "can cause GC (and hence reduce number of roots)"
	j := 0.
	1 to: rootTableCount do:
		[:i| "By definition the roots are old and being new, tableObj is young so there is no need to store check."
		self storePointerUnchecked: j ofObject: tableObj withValue: (rootTable at: i)].
	rootTableCount < sz ifTrue:
		[self shorten: tableObj toIndexableSize: rootTableCount].
	^tableObj