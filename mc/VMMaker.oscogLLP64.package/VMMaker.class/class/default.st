initialisation
default
	"return a VMMaker initialised to build a default no-internal-plugins, no-external-plugins vm codebase"
	^self forPlatform: (true
						ifTrue: ['Cross'] 
						ifFalse: [SmalltalkImage current platformName])