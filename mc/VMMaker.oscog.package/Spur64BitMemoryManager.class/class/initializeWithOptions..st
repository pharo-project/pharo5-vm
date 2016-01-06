class initialization
initializeWithOptions: optionsDictionary
	"SpurMemoryManager initializeWithOptions: Dictionary new"

	optionsDictionary at: #Spur64BitMemoryManager put: true.
	super initializeWithOptions: optionsDictionary