accessing
containsMismatchedJoin
	| end |
	end := self method endPC.
	[[self pc <= end]
		whileTrue:
			[((joins at: pc) notNil and: [stackp ~= (joins at: pc)]) ifTrue: [^true].
			 self interpretNextInstructionFor: self]]
		on: Notification
		do: [:ex|
			ex tag == #'bad join' ifTrue: [^true].
			ex pass].
	^false

	"StackDepthFinder methodDict values collect: [:m| (StackDepthFinder on: m) stackPointers]"
	"StackDepthFinder methodDict values select: [:m| (StackDepthFinder on: m) containsMismatchedJoin]"

	"| jumpers |
	 jumpers := CompiledMethod allInstances select:
						[:cm| | is |
						is := InstructionStream on: cm.
						is scanFor: [:ign| is willJump]].
	(jumpers select: [:cm| (StackDepthFinder on: cm) containsMismatchedJoin])
			asSortedCollection: [:cm1 :cm2| cm1 endPC <= cm2 endPC]"

	"| jumpers |
	 jumpers := CompiledMethod allInstances select:
						[:cm| | is |
						is := InstructionStream on: cm.
						is scanFor: [:ign| is willJump]].
	(jumpers reject: [:cm| (StackDepthFinder on: cm) containsMismatchedJoin])
			asSortedCollection: [:cm1 :cm2| cm1 endPC <= cm2 endPC]"

	"| jumpers result |
	 jumpers := CompiledMethod allInstances select:
						[:cm| | is |
						is := InstructionStream on: cm.
						is scanFor: [:ign| is willJump]].
	result := (jumpers select: [:cm| (StackDepthFinder on: cm) containsMismatchedJoin])
				asSortedCollection: [:cm1 :cm2| cm1 endPC <= cm2 endPC].
	 SystemNavigation new browseMessageList: (result collect: [:ea| ea methodReference]) name: 'mismatched joins'.
	 result"