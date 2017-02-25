inline cacheing
relocateJumpLongConditionalBeforeFollowingAddress: pc by: delta
	"Relocate a long conditional jump before pc.  Default to relocating a non-conditional jump.
	 Processors that have different formats for conditional and unconditional jumps override."
	self relocateJumpLongBeforeFollowingAddress: pc by: delta