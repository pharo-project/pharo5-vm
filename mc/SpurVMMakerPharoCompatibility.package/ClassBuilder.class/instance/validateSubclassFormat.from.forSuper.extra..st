validation
validateSubclassFormat: newType from: oldClass forSuper: newSuper extra: newInstSize
	"Validate the # of instVars and the format of the subclasses"
	| deltaSize |
	oldClass == nil ifTrue: [^ true]. "No subclasses"
	"Compute the # of instvars needed for all subclasses"
	deltaSize := newInstSize.
	(oldClass notNil)
		ifTrue: [deltaSize := deltaSize - oldClass instVarNames size].
	(newSuper notNil)
		ifTrue: [deltaSize := deltaSize + newSuper instSize].
	(oldClass notNil and: [oldClass superclass notNil]) 
		ifTrue: [deltaSize := deltaSize - oldClass superclass instSize].
	(oldClass == nil)
		 ifTrue: [ (deltaSize > 254)
					ifTrue: [ self error: 'More than 254 instance variables'.
							^ false].
				  ^ true].

	oldClass withAllSubclassesDo: [:sub |  ( sub instSize + deltaSize > 254 )
											ifTrue: [ self error: sub name,' has more than 254 instance variables'.
					 								^ false].

										"If we get this far, check whether the immediate subclasses of oldClass can keep its layout."
               							(newType ~~ #normal) 
											ifTrue: [ self validateSubclass: sub canKeepLayoutFrom: oldClass forSubclassFormat: newType ]].

	^ true