class definition
recompile: force from: oldClass to: newClass mutate: forceMutation
	"Do the necessary recompilation after changine oldClass to newClass.
	If required (e.g., when oldClass ~~ newClass) mutate oldClass to newClass
	and all its subclasses. If forceMutation is true force a mutation even
	if oldClass and newClass are the same."

	oldClass == nil ifTrue:[^ newClass].

	(newClass == oldClass and:[force not and:[forceMutation not]]) ifTrue:[
		^newClass].

	currentClassIndex := 0.
	maxClassIndex := oldClass withAllSubclasses size.

	(oldClass == newClass and:[forceMutation not]) ifTrue:[
		"Recompile from newClass without mutating"
		self informUserDuring:[

			newClass withAllSubclassesDo:[:cl|
				self showProgressFor: cl.
				cl compileAll]].
		^newClass].
	"Recompile and mutate oldClass to newClass"
	self informUserDuring:[

		self mutate: oldClass to: newClass.
	].
	^oldClass "now mutated to newClass"