patching
patchForPackage: package withPatches: patches snapshot: snapshot
	(package includesClass: Character) ifTrue:
		[patches
			addAll: ((self modifiedCharacterDefinitionsIn: snapshot definitions)
						select:
							[:def|
							 patches noneSatisfy:
								[:addition|
								def isMethodDefinition
								and: [addition definition isMethodDefinition
								and: [addition definition selector = def selector
								and: [addition definition className = def className
								and: [addition definition classIsMeta = def classIsMeta]]]]]]
						thenCollect:
							[:def|
							 ((def source includesSubString: 'DELETEME')
								ifTrue: [MCRemoval]
								ifFalse: [MCAddition]) of: def]);
			add: (self immediateClassDefinitionFor: #Character
					from: snapshot definitions
					comment: 'I represent a character by storing its associated Unicode as an unsigned 30-bit value.  Characters are created uniquely, so that all instances of a particular Unicode are identical.  My instances are encoded in tagged pointers in the VM, so called immediates, and therefore are pure immutable values.

	The code point is based on Unicode.  Since Unicode is 21-bit wide character set, we have several bits available for other information.  As the Unicode Standard  states, a Unicode code point doesn''t carry the language information.  This is going to be a problem with the languages so called CJK (Chinese, Japanese, Korean.  Or often CJKV including Vietnamese).  Since the characters of those languages are unified and given the same code point, it is impossible to display a bare Unicode code point in an inspector or such tools.  To utilize the extra available bits, we use them for identifying the languages.  Since the old implementation uses the bits to identify the character encoding, the bits are sometimes called "encoding tag" or neutrally "leading char", but the bits rigidly denotes the concept of languages.

	The other languages can have the language tag if you like.  This will help to break the large default font (font set) into separately loadable chunk of fonts.  However, it is open to the each native speakers and writers to decide how to define the character equality, since the same Unicode code point may have different language tag thus simple #= comparison may return false.'
					stamp: 'eem 8/12/2014 14:53')].
	(package includesClass: SmallInteger) ifTrue:
		[patches
			add: (self
					immediateClassDefinitionFor: #SmallInteger
					from: snapshot definitions
					comment: 'My instances are at least 31-bit numbers, stored in twos complement form. The allowable range in 32-bits is approximately +- 10^9 (+- 1billion).  In 64-bits my instances are 61-bit numbers, stored in twos complement form. The allowable range is approximately +- 10^18 (+- 1 quintillion).   The actual values are computed at start-up.  See SmallInteger class startUp:, minVal, maxVal.'
					stamp: 'eem 11/20/2014 08:41')].
	(package includesClass: CompiledMethod) ifTrue:
		[patches
			add: (self compiledMethodClassDefinition)].
	^MCPatch operations: patches