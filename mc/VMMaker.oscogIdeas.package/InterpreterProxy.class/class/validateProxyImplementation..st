private
validateProxyImplementation: anInterpreter 
	"InterpreterProxy validateProxyImplementation: Interpreter"

	| proxyClass catList |
	proxyClass := InterpreterProxy.
	catList := proxyClass organization categories copy asOrderedCollection.
	catList remove: 'initialize' ifAbsent:[].
	catList remove: 'private' ifAbsent:[].
	catList do:[:categ|
		(proxyClass organization listAtCategoryNamed: categ) do:[:selector|
			(anInterpreter canUnderstand: selector) 
				ifFalse:
					[self notifyWithLabel: selector, ' is not implemented in ', anInterpreter name]]]