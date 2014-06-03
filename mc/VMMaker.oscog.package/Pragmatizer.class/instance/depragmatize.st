convert pragmas to sends
depragmatize
	"Convert methods from pragmas to old style message send directives, retaining
	original author initials and time stamps. Answer the methods that were modified."

	| instanceMethods |
	"Only instance side methods are translated, so ignore class side methods in the package"
	instanceMethods := package methods
				reject: [:e | e classIsMeta
						or: [self isExcludedClass: e]].
	^ instanceMethods
		reject: [:mr | self depragmatize: mr]