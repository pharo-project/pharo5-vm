debug printing
printAtCache
	0 to: AtCacheTotalSize - 1 by: 4 do:
		[:i | | obj sz fmt fixed |
		obj := atCache at: i + AtCacheOop.
		sz := atCache at: i + AtCacheSize.
		fmt := atCache at: i + AtCacheFmt.
		fixed := atCache at: i + AtCacheFixedFields.
		(objectMemory addressCouldBeObj: obj) ifTrue:
			[self transcript ensureCr.
			 self print: i; tab; print: (i < AtPutBase ifTrue: ['at   '] ifFalse: ['put ']);
				tab; printNum: sz; tab; printNum: fmt; tab; printNum: fixed; tab;
				shortPrintOop: obj]]