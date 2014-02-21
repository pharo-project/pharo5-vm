accessing
addExternalDependency: aString 
	"We need to collect external dependencies to internal plugins because we need to force its 
	resolve before, and if we just add teh dependency in executable some times is not enough. 
	check StackIPhoneConfig>>#configureFT2Plugin: as an example"
	externalDependencies := externalDependencies copyWith: aString.