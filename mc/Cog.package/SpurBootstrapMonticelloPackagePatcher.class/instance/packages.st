private-accessing
packages
	"SpurBootstrapMonticelloPackagePatcher new packages"
	| packages |
	packages := Set new.
	SpurBootstrap new prototypeClassNameMetaSelectorMethodDo:
		[:className :isMeta :selector :method| | class |
		 class := Smalltalk classNamed: className.
		 isMeta ifTrue:
			[class := class class].
		 packages add: ((class includesSelector: selector)
							ifTrue: [PackageOrganizer default packageOfMethod: (class >> selector) methodReference]
							ifFalse: [PackageOrganizer default  packageOfClass: class])].
	^packages