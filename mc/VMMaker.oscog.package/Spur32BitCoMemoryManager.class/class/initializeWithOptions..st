class initialization
initializeWithOptions: optionsDictionary
	"SpurMemoryManager initializeWithOptions: Dictionary new"

	optionsDictionary at: #Spur32BitMemoryManager put: true.
	super initializeWithOptions: optionsDictionary