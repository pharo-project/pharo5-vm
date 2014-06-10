*CogVMMakerPharoCompatibility
superclassOrder: classes
	"Arrange the classes in the collection, classes, in superclass order so the 
	classes can be properly filed in. Do it in sets instead of ordered collections.
	SqR 4/12/2000 22:04"

	| all list inclusionSet cache |

	list := classes copy. "list is indexable"
	inclusionSet := list asSet. cache := Dictionary new.
	all := OrderedCollection new: list size.
	list size timesRepeat:
		[ | aClass aClassIndex |
			aClassIndex := list findFirst: [:one | one notNil and: 
				[self doWeFileOut: one given: inclusionSet cache: cache]].
			aClass := list at: aClassIndex.
			all addLast: aClass.
			inclusionSet remove: aClass.
			list at: aClassIndex put: nil
		].
	^all