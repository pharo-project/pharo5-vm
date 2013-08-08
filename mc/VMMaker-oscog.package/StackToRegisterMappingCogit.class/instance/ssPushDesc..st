simulation stack
ssPushDesc: simStackEntry
	<var: #simStackEntry type: #CogSimStackEntry>
	self cCode:
			[simStackEntry type = SSSpill ifTrue:
				[simStackEntry type: SSBaseOffset].
			simStackEntry
				spilled: false;
				annotateUse: false;
				bcptr: bytecodePC.
			 simStack
				at: (simStackPtr := simStackPtr + 1)
				put: simStackEntry]
		inSmalltalk:
			[(simStack at: (simStackPtr := simStackPtr + 1))
				copyFrom: simStackEntry;
				type: (simStackEntry type = SSSpill
						ifTrue: [SSBaseOffset]
						ifFalse: [simStackEntry type]);
				spilled: false;
				annotateUse: false;
				bcptr: bytecodePC].
	simSpillBase > simStackPtr ifTrue:
		[simSpillBase := simStackPtr max: 0].
	^0