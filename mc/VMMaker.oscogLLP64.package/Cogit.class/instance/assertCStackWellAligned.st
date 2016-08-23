simulation only
assertCStackWellAligned
	"Check alignment of the C stack.  This is a simulation only facsimilie.
	 See platforms/Cross/vm/sqCogStackAlignment.h for the real code."
	<doNotGenerate>
	self assert: processor sp \\ cStackAlignment = expectedSPAlignment.
	self assert: processor fp \\ cStackAlignment = expectedFPAlignment