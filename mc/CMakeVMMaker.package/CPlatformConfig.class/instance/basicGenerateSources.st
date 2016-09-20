source generation
basicGenerateSources
	| maker |

	self validateSourcesPresent.
	self prepareForGeneration.
	
	"suppress questions and deprecation warnings during generation "
	[[
		maker := self prepareVMMaker.
		maker interpreterClass: self interpreterClass.
		"If #cogitClass is nil it will add Cogit->'nil' pair. 
		 This is *CORRECT*, check VMClass class>>#cogitClass for insigts on the use"
		maker options: { #Cogit. self cogitClass name }.
		self interpreterClass initializeWithOptions: maker options.
		self cogitClass ifNotNil: [ :cg | 
			cg initializeWithOptions: maker options ].
		maker logDateAndTime.
		"VM"
		maker 
			sourceDirectoryName: self srcDir;
			generateInterpreterFile;
			generateCogitFiles;
			processFilesForCoreVM;
			generateExportsFile.
		"Plugins"
		maker 
			sourceDirectoryName: self srcPluginsDir;
			generateInternalPlugins;
			generateExternalPlugins.
		maker logDateAndTime.
	] on: ProvideAnswerNotification do: [:ex | ex resume: true ]]
	on: Deprecation do: [:ex | ex resume ].
