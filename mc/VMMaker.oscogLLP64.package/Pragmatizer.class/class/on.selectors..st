instance creation
on: packageName selectors: selectorList
	"Pragmatizer on: 'VMMaker-Interpreter' selectors: #(#export: #static: #inline: #returnTypeC: #var:declareC: #var:type: )"
	"Pragmatizer on: 'VMMaker-Plugins' selectors: #(#export: #static: #inline: #returnTypeC: #var:declareC: #var:type: )"
	"Pragmatizer on: 'VMMaker-SmartSyntaxPlugins' selectors: #(#export: #static: #inline: #returnTypeC: #var:declareC: #var:type: )"

	^ self new package: packageName selectors: selectorList