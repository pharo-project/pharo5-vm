inlining
doInlining: inlineFlag
	"do inlining for a plugin; avoid doing it twice and make sure that
	 primitive prolog preparation is done immediately after inlining.
	 Also, since sharing between plugins means that normal pruning
	 can't be done, allow plugins that want to prune specific methods."
	inliningDone ifFalse:
		[self doBasicInlining: inlineFlag.
		 self prepareTranslatedPrimitives.
		 pluginClass methodsToBePruned do:
			[:sel|
			methods removeKey: sel].
		 inliningDone := true]