interpreter access
classTagForClass: classObj
	"Answer the classObj's identityHash to use as a tag in the first-level method lookup cache."
	self assert: (coInterpreter addressCouldBeClassObj: classObj).
	^self ensureBehaviorHash: classObj