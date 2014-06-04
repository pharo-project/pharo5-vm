become implementation
postBecomeScanClassTable
	"Scan the class table post-become (iff a pointer object or compiled method was becommed).
	 Note that one-way become can cause duplications in the class table.
	 When can these be eliminated?  We use the classtableBitmap to mark  classTable entries
	 (not the classes themselves, since marking a class doesn't help in knowing if its index is used).
	 On image load, and during incrememtal scan-mark and full GC, classIndices are marked.
	 We can somehow avoid following classes from the classTable until after this mark phase."

	self assert: self validClassTableRootPages.

	(becomeEffectsFlags anyMask: BecamePointerObjectFlag+BecameCompiledMethodFlag) ifFalse: [^self].
	
	self postBecomeOrCompactScanClassTable: becomeEffectsFlags