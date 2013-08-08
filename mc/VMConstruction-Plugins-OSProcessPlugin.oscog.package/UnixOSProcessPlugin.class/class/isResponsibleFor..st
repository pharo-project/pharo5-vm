translation
isResponsibleFor: platform 
	"Answer true is this is an instance of the class which is responsible for
	representing the named platform."

	^ platform = 'unix'
		or: [platform = 'Mac OS']