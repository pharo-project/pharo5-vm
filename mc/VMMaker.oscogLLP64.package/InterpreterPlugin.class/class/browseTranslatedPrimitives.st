translated primitives
browseTranslatedPrimitives
	"InterpreterPlugin browseTranslatedPrimitives"
	| methodRefs |
	methodRefs := OrderedCollection new.
	self withAllSubclasses do:
		[:class|
		methodRefs addAll:
			(class translatedPrimitives collect:
				[:tuple|
				(self methodForTranslatedPrimitiveTuple: tuple) methodReference])].
	self systemNavigation browseMessageList: methodRefs
		name: 'Translated primitives'