C code generator
needToGenerateHeader: headerName file: interpHdrPath contents: newContentsArg
	"Check if we need to regenerate a header file.  We always need to if the contents have changed.
	 But if not we can avoid needless recompilations by not regenerating.  So only regenerate if the
	 package stamp is dirty and the monticello stamp is clean."
	| newContents oldContents dirtyStamp |
	(FileDirectory default fileExists: interpHdrPath) ifFalse:
		[^true].
	newContents := newContentsArg.
	oldContents := (FileDirectory default oldFileNamed: interpHdrPath) contentsOfEntireFile.
	oldContents := oldContents copyReplaceAll: {Character cr. Character lf} with: {Character cr}.
	oldContents replaceAll: Character lf with: Character cr.
	dirtyStamp := (oldContents indexOfSubCollection: '* VMMaker') ~= 0.
	(newContents beginsWith: '/*') = (oldContents beginsWith: '/*') ifFalse:
		[(newContents beginsWith: '/*') ifTrue:
			[newContents := newContents readStream upToAll: '*/'; skipSeparators; upToEnd].
		 (oldContents beginsWith: '/*') ifTrue:
			[oldContents := oldContents readStream upToAll: '*/'; skipSeparators; upToEnd]].
	^oldContents ~= newContents
	 or: [(dirtyStamp and: [[((self class monticelloDescriptionFor: vmClass) includes: $*) not]
							on: Error do: [:ex| false]]) "If no stamp don't worry"
	 or: [self confirm: headerName, ' contents are unchanged.\Writing the file may cause recompilation of support files.\Do you want to write the header file?' withCRs]]