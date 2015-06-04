compaction
savePICUsageCount: cogMethod
	"For Sista, where we want PICs to last so they can be observed, we need to keep PICs unless
	 they are definitely unused.  So we need to identify unused PICs.  So in planCompact, zero the
	 usage counts of all PICs, saving the actual usage count in blockEntryOffset.  Then in
	 relocateMethodsPreCompaction (actually in relocateIfCallOrMethodReference:mcpc:delta:)
	 restore the usage counts of used PICs.  Finally in compactCompiledCode, clear the blockEntryOffset
	 of the unused PICs; they will then have a zero count and be reclaimed in the next code compaction."
	<var: #cogMethod type: #'CogMethod *'>
	<option: #SistaVM>
	cogMethod cmType = CMClosedPIC ifTrue:
		[cogMethod
			blockEntryOffset: cogMethod cmUsageCount;
			cmUsageCount: 0]