inline cacheing
zoneCallsAreRelative
	"Answer if Call and JumpLong are relative and hence need to take the caller's
	 relocation delta into account during code compaction, rather than just the
	 callee's delta."
	^false