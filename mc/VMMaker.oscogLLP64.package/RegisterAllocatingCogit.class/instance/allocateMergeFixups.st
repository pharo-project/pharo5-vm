compile abstract instructions
allocateMergeFixups
	"Allocate the various arrays needed to allocate the merge fixups, failing if the size
	 needed is considered too high.

	 This *must* be inlined since the arrays are alloca'ed (stack allocated)
	 so that they are freed when compilation is done.

	 N.B. We do one single alloca to save embarrassing C optimizers that
	 generate incorrect code as both gcc and the intel compiler do on x86."
	<inline: true>
	| mergeSimStackBytes |
	mergeSimStackBytes := numFixups * self simStackSlots * (self sizeof: CogSimStackEntry).
	nextFixup := 0.
	self cCode:
		[mergeSimStacksBase := self alloca: mergeSimStackBytes.
		 self b: mergeSimStacksBase zero: mergeSimStackBytes]