inline cacheing
relocateJumpLongBeforeFollowingAddress: pc by: delta
	"We assume here that calls and jumps look the same as regards their displacement.
	 This works on at least x86, ARM and x86_64.  Processors on which that isn't the
	 case can override as necessary."
	self relocateCallBeforeReturnPC: pc by: delta