accessing
displayView: anImageMorph
	"The VM SImulator draws directly on an imageMorph named displayView
	  displayView is housed on a Form named displayForm
	  Since this is housed directly on the Morph, I have this tight compling from here->model->morph. 
	"
	self flag: 'tty'.
	displayView := anImageMorph