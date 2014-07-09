separate vm scripts
browseExclusiveMethodImportsForPrimitiveClass: primClass
	"Browse methods used by the class holding VM primitives and unused elsewhere."
	"self browseExclusiveMethodImportsForPrimitiveClass: StackInterpreterSPrimitives"
	Cursor execute showWhile:
		["The algorithm computes a fixed point of the methods used
		   by the parcel which are unused outside it.  The algorithm is
				compute messages sent within parcel
				repeat until at a fixed point:
					compute intersection of this with methods implemented outside parcel
					compute messages sent outside parcel not within the intersection
					remove these from intersection"

		| parcelMessages "<IdentitySet of: Symbol>
								messages sent within this parcel"
		  externalMethods "<Set of: MethodDescription>
								methods implemented outside this parcel"
		  danglingMethods "<Set of: MethodDescription>
								methods importeded only by this parcel"
		  previousDangling "<Set of: MethodDescription>
								intermediate value of danglingMethods (for determining if fixed point is reached)"
		  danglingMessages "<Set of: Symbol> selectors of methods in danglingMethods"
		  noLongerDangling "<Set of: Symbol> selectors to be moved from dangling" |

		parcelMessages := IdentitySet new.
		primClass methodsDo:
			[:meth| parcelMessages addAll: meth messages].
		"compute starting points for danglingMethods and externalMethods"
		danglingMethods := Set new: 50.
		externalMethods := Set new: 20000.
		(PackageInfo named: 'VMMaker') classes do:
			[:aBehavior| | extends |
			(aBehavior = primClass or: [aBehavior inheritsFrom: primClass]) ifFalse:
				[aBehavior selectorsAndMethodsDo:
					[:sel :meth|
					(primClass includesSelector: sel) ifFalse:
						[((parcelMessages includes: sel)
							ifTrue: [danglingMethods]
							ifFalse: [externalMethods])
								add: (MethodReference class: aBehavior selector: sel)]]]].
		["Now iterate to the fixed-point.  Any method in dangling with a selector sent
		  in external must be moved into external until dangling reaches its fixed point."
		previousDangling := danglingMethods copy.
		danglingMessages := danglingMethods collect: [:md| md selector].
		noLongerDangling := Set new: danglingMethods size.
		externalMethods do:
			[:md|
			md compiledMethod messages do:
				[:l|
				(danglingMessages includes: l) ifTrue:
					[noLongerDangling add: l]]].
		externalMethods := danglingMethods select: [:md| noLongerDangling includes: md selector].
		danglingMethods removeAll: externalMethods.
		danglingMethods size ~= previousDangling size] whileTrue.
		SystemNavigation default
			browseMessageList: danglingMethods asSortedCollection
			name: 'Methods Used Only by ', primClass name, ' but not in ', primClass name]