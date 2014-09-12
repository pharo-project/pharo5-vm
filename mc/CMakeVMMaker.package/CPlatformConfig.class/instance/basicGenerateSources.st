source generation
basicGenerateSources
	| maker |

	self validateSourcesPresent.
	self prepareForGeneration.
	
	"suppress questions and deprecation warnings during generation "
	[[
		maker := self prepareVMMaker.
		maker interpreterClass: self interpreterClass.
		self cogitClass ifNotNil: [:cg | 
			maker 
				instVarNamed: 'optionsDictionary' 
				put:  (maker options copy
					at: #Cogit put: self cogitClass name;
					yourself).
			cg initializeWithOptions: maker options ].
		maker generateEntire
	] on: ProvideAnswerNotification do: [:ex | ex resume: true ]]
	on: Deprecation do: [:ex | ex resume ].
