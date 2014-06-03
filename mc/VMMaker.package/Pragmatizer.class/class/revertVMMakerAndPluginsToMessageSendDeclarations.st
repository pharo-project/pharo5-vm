examples
revertVMMakerAndPluginsToMessageSendDeclarations
	"To revert back to the message send declarations. "
	
	"Pragmatizer revertVMMakerAndPluginsToMessageSendDeclarations"

	| selectorsToConvert packages converter substringToRemoveFromMethodStamp |

	"Optional - Edit the following to match substring to be removed from the method
	stamps to return them to their original form prior to conversion to pragmas:
	Note leading space in the string."
	substringToRemoveFromMethodStamp := ' (auto pragmas dtl 2010-09-26)'.

	selectorsToConvert := #(#export: #static: #inline: #returnTypeC: #var:declareC: #var:type: ).
	packages := { 'VMMaker-Interpreter' . 'VMMaker-Plugins' . 'VMMaker-SmartSyntaxPlugins' }.
	packages do: [:package |
		converter := Pragmatizer on: package selectors: selectorsToConvert.
		converter stampCutString: substringToRemoveFromMethodStamp.
		converter stampInsertString: ''.
		converter depragmatize]