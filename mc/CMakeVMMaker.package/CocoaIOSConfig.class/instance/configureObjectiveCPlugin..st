plugin extra rules
configureObjectiveCPlugin: maker 
	"extra rules for ObjectiveCPlugin"

	maker addDefinitions: ' -x objective-c'.
	maker addFrameworks: self frameworks.
	maker includeDirectories: '${platformsDir}/iOS/plugins/SqueakObjectiveC'.
	maker 
		addSources: #('squeakProxy.m' 'squeakSUnitTester.m') 
		prefixed: '${platformsDir}/iOS/plugins/SqueakObjectiveC/'.
	