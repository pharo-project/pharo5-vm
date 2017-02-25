interpreter access
classTagForClass: classObj
	"Answer the classObj's identityHash to use as a tag in the first-level method lookup cache."
	<api>
	^self ensureBehaviorHash: classObj