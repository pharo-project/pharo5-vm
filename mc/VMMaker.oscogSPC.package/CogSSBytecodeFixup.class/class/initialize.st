class initialization
initialize
	"Initialize the fixup flags.  In this class we have two states.  A fixup is a bytecode
	 being targeted by a branch, and a jump can target the fixup before the byetcode
	 is generated.  A non-merge fixup is that for a bytecode that follows a return instruction.
	 There is no control flow merge from the preceding instruction for this kind of fixup.
	 A merge fixup is that for a bytecode where control flow arrives from both the preceding
	 instruction and a branch.  When compileAbstractInstructionsFrom:to: finds a merge
	 fixup, it must both set the targetInstruction and merge the stack/register state of the
	 control flow from the preceding instruction with the stack/register state from the branch.
	 Later still, when code is generated jumps follow fixups to eliminate the fixup and target
	 the right instruction."
	NeedsNonMergeFixupFlag := 1.
	NeedsMergeFixupFlag := 2.
	self assert: NeedsNonMergeFixupFlag < NeedsMergeFixupFlag.

	UnknownSimStackPtrFlag := -2