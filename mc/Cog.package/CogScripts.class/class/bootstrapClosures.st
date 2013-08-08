closure scripts
bootstrapClosures
	"CogScripts bootstrapClosures"
	| rep |
	Transcript clear.
	rep := false
			ifTrue: [MCCacheRepository default]
			ifFalse:
				[MCHttpRepository
					location: 'http://dev.qwaq.com/ss/Oinq'
					user: 'qwaq'
					password: ''].
	"This changes load order in Monticello such that additions come in before modifications."
	(rep loadVersionFromFileNamed: 'Monticello-eem.302.mcz') load.
	"This adds some prereqs the compiler uses that are loaded in later packages:
	 Fix the ClassBuilder so redefining CompiledMethod can add and remove class variables.
	 Add Object/Array>>isArray.
	 Add new interface for accessing inst vars & fields on initializing the compiler (Encoder)."
	self bootstrapClosuresCompilerPreloadCode readStream fileIn.
	"This temporarily stops Monticello from unloading code on load and warning about overwriting changes.
	 Since changes span multiple packages need all additions in before any deletions occur.
	 Can't warn about anything until the new debugger api is installed."
	ChangeSet
		newChangesFromStream: self bootstrapClosuresNeuterMonticelloCode readStream
		named: 'neuterMonticello'.
	Smalltalk at: #DoNotUnload put: true.
	1 to: 2 do:
		 [:i|
		  #(	'Compiler-eem.30.mcz'
			'Files-eem.21.mcz'
			'Exceptions-eem.14.mcz'
			'Collections-eem.55.mcz'
			'Tools-eem.45.mcz'
			'Kernel-eem.82.mcz'
			'System-eem.53.mcz'
			'Brad-eem.51.mcz'
			'Morphic-eem.38.mcz'
			'Tweak-Compiler-eem.36.mcz'
			'Tweak-Hacks-eem.30.mcz'
			'Tweak-Basic-eem.151.mcz'
			'Tweak-Core-Proto-eem.56.mcz') do:
				[:pn|
				Transcript clear; nextPutAll: pn; space; nextPut: $(; print: i; nextPut: $); endEntry.
				(rep loadVersionFromFileNamed: pn) load].
		 Smalltalk at: #DoNotUnload put: false].
	"Now remove the temporary hacks to Monticello"
	(ChangeSet named: 'neuterMonticello') changedMessageList do:
		[:mr| | changeRecords |
		changeRecords := mr actualClass changeRecordsAt: mr methodSymbol.
		changeRecords second fileIn].
	"Install BlockClosure in the specialObjectsArray"
	Smalltalk recreateSpecialObjectsArray.
	"Throw the switch to compile to closures"
	self bootstrapClosuresClosureCompilerSwitchCode readStream fileIn.
	"Recompile the system except the one method we can't yet deal with in GeniePlugin (1 too many literals)"
	(Smalltalk forgetDoIts allClasses reject: [:c| c name == #GeniePlugin]) do:
		[:c|
		{ c. c class } do:
			[:b|
			Transcript cr; print: b; endEntry.
			b selectors asSortedCollection do:
				[:s|
				b recompile: s from: b]]].
	UsefulScripts postRecompileCleanup.
	self inform: 'Save and quit and then run UsefulScripts postRecompileCleanup.\Rinse and repeat' withCRs