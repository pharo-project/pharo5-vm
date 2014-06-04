accessing
displayForm
	"The VM SImulator draws directly on an imageMorph named displayView
	  displayView is housed on a Form named displayForm
	  displayForm is initialized in my initialize method. 
	  it 'needs' to be initialized there to support Eliot's legacy openAsMorph functionality
	"
	^displayForm