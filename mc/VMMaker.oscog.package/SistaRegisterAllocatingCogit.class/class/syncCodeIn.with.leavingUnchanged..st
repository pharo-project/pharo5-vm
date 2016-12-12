class initialization
syncCodeIn: sourceClass with: destClass leavingUnchanged: selectorOrNil
	"Make sure that the SistaRegisterAllocatingCogit/SistaCogitClone combination is up-to-date w.r.t. SistaCogit.
	 - 	SistaCogitClone should have all methods in SistaCogit except those implemented in SistaRegisterAllocatingCogit.
		This means that super sends in SistaCogitClone will be understood in SistaRegisterAllocatingCogit, not
		SistaRegisterAllocatingCogit.
	 -	newer methods in SistaCogitClone that are implemented in SistaRegisterAllocatingCogit should be moved up to
		SistaRegisterAllocatingCogit becaude it means that we probably changed them in SistaCogitClone by mistake
		and forgot to copy them up.
	 -	the same goes for the class side, except for the intializeWithOptions: method which /should/ exist in both
		SistaRegisterAllocatingCogit and SistaCogitClone, because it runs this initialization."

	| methodTimeStamp |
	methodTimeStamp := selectorOrNil ifNotNil:
					[(destClass superclass >>> selectorOrNil) isValid ifTrue:
						[(destClass >>> selectorOrNil) isValid
							ifTrue: [(destClass >>> selectorOrNil) timeStamp]
							ifFalse: ['ancient 01/01/1901 00:00']]].

	destClass selectorsDo:
		[:s|
		(s ~~ selectorOrNil
		 and: [(destClass superclass >>> s) isValid
		 and: [self implementation: destClass >>> s isNewerThan: destClass superclass >>> s]]) ifTrue:
			[destClass superclass recompile: s from: destClass.
			 (destClass superclass whichCategoryIncludesSelector: s) ~= (destClass whichCategoryIncludesSelector: s) ifTrue:
				[destClass superclass organization classify: s under: (destClass whichCategoryIncludesSelector: s)]]].

	sourceClass selectorsDo:
		[:s|
		(self implementation: sourceClass >>> s isDifferentThan: destClass >>> s) ifTrue:
			[destClass recompile: s from: sourceClass.
			 (destClass whichCategoryIncludesSelector: s) ~= (sourceClass whichCategoryIncludesSelector: s) ifTrue:
				[destClass organization classify: s under: (sourceClass whichCategoryIncludesSelector: s)]]].


	destClass superclass selectorsDo:
		[:s|
		(s ~~ selectorOrNil
		 and: [(destClass >>> s) isValid]) ifTrue:
			[destClass removeSelector: s]].

	^methodTimeStamp notNil
	  and: [(destClass >>> selectorOrNil) isValid
	  and: [(methodTimeStamp beginsWith: 'ancient')
		or: [(self dateAndTimeFrom: (destClass >>> selectorOrNil) timeStamp) ~= (self dateAndTimeFrom: methodTimeStamp)]]]