source generation
generateVMOnlySources
	"Generate source code for VM only, without plugins"
	| maker |

	self validateSourcesPresent.
	self prepareForGeneration.
	
	"suppress questions and deprecation warnings during generation "
	[[
		
		maker := self prepareVMMaker.
	
		maker interpreterClass: self interpreterClass.
		self cogitClass ifNotNil: [:cg | maker cogitClass: cg ].

	
		maker generateMainVM

	] on: ProvideAnswerNotification do: [:ex | ex resume: true ]]
	on: Deprecation do: [:ex | ex resume ].
	

