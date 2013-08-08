utilities
removeThreadedSubSystem
	"VMClass removeQwaqPlugins.
	 VMClass removeThreadedSubSystem"
	"For releasing/merging OSCog"
	SystemChangeNotifier uniqueInstance doSilently:
		[CogVMSimulator
			removeSelector: #isThreadedVM;
			removeSelector: #initializeThreadSupport;
			removeSelector: #initialEnterSmalltalkExecutive;
			removeSelector: #ensureMultiThreadingOverridesAreUpToDate.
		(CogVMSimulator organization listAtCategoryNamed: #'multi-threading simulation switch') do:
			[:s| CogVMSimulator removeSelector: s].
		CoInterpreterPrimitives
			subclass: #CogVMSimulator
			instanceVariableNames: CogVMSimulator instanceVariablesString
			classVariableNames: CogVMSimulator classVariablesString
			poolDictionaries: CogVMSimulator sharedPoolsString
			category: CogVMSimulator category.
		SystemOrganization removeSystemCategory: #'VMMaker-Multithreading'.
		self class removeSelector: thisContext selector].
	(Smalltalk classNamed: #MCWorkingCopy) ifNotNil:
		[:mcwc|
		(mcwc forPackage: (MCPackage named: 'VMMaker')) modified: true]