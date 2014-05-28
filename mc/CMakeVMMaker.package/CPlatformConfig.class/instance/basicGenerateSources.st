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
			maker cogitClass: cg.
			cg initializeWithOptions: (maker instVarNamed: 'optionsDictionary')
		].
		
		maker generateEntire

	] on: ProvideAnswerNotification do: [:ex | ex resume: true ]]
	on: Deprecation do: [:ex | ex resume ].
