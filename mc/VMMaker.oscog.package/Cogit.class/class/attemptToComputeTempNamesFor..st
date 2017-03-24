in-image compilation support
attemptToComputeTempNamesFor: aCompiledMethod
	(aCompiledMethod respondsTo: #tempNames) ifTrue:
		[| blocks |
		 blocks := aCompiledMethod embeddedBlockClosures.
		 initializationOptions
			at: #tempNames
			put: (Dictionary withAll: {aCompiledMethod initialPC -> ([aCompiledMethod tempNames]
																		on: MessageNotUnderstood
																		do: [:ex|
																			(self isSistaMessage: ex message unimplementedIn: Decompiler) ifTrue:
																				[^self].
																			 (Smalltalk classNamed: #AssemblerAbsentClassImport) ifNotNil:
																				[:aaciClass|
																				 (ex receiver isKindOf: aaciClass) ifTrue:
																					[^self]].
																			 ex pass])},
				(blocks
					ifEmpty: [#()]
					ifNotEmpty:
						[aCompiledMethod embeddedBlockClosures
							with: ((aCompiledMethod methodNode schematicTempNamesString allButFirst:
									(aCompiledMethod methodNode schematicTempNamesString indexOf: $[)) piecesCutWhere: [:a :b| b = $[])
							collect: [:c :s| c startpc -> s substrings]]))]