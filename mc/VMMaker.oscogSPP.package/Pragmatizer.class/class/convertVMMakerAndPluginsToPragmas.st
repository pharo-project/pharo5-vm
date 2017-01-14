examples
convertVMMakerAndPluginsToPragmas
	"Create (unused) packages named 'VMMaker-Interpreter', 'VMMaker-Plugins',
	and 'VMMaker-SmartSyntaxPlugins'. Open a transcript, then evaluate this method.
	Some errors will be found during the conversion. Fix the problem methods
	manually in the notifier dialog, and proceed. The issues are related to declarations
	that are not the first lines of source in the method, so just move the declarations
	to the top of the method to resolve."
	
	"Pragmatizer convertVMMakerAndPluginsToPragmas"

	| selectorsToConvert packages converter |
	selectorsToConvert := #(#export: #static: #inline: #returnTypeC: #var:declareC: #var:type: ).
	packages := { 'VMMaker-Interpreter' . 'VMMaker-Plugins' . 'VMMaker-SmartSyntaxPlugins' }.
	packages do: [:package |
		converter := Pragmatizer on: package selectors: selectorsToConvert.
		converter pragmatize]