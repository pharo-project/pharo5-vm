initialize-release
package: packageName selectors: selectorList

	package := PackageOrganizer default
		packageNamed: packageName
		ifAbsent: [self error: 'package ', packageName, ' not found'].
	selectors := selectorList