become implementation
postCompactScanClassTable
	"Scan the class table post-compact.  Ensure all pages and
	 all classes are not forwarded."

	0 to: numClassTablePages - 1 do:
		[:i| | page |
		page := self fetchPointer: i ofObject: hiddenRootsObj.
		(self isForwarded: page) ifTrue: "this check is for eliminateAndFreeForwarders"
			[page := self followForwarded: page.
			 self storePointer: i ofObject: hiddenRootsObj withValue: page]].
	self assert: self validClassTableRootPages.	
	self postBecomeOrCompactScanClassTable: BecamePointerObjectFlag+BecameCompiledMethodFlag