LargeIntegersPlugin provides functions for speeding up LargeInteger arithmetics. Usually it is part of your installation as 'LargeIntegers' plugin (a C-compiled binary).


Correctly installed?
----------------------
Probably you are just working with it.

To be really sure try
	100 factorial. "to force plugin loading"
	SmalltalkImage current listLoadedModules.
Then you should see 'LargeIntegers' somewhere in the output strings. If this should not be the case, you probably have a problem.


Variables
-----------

Inst vars:
	andOpIndex			C constant
	orOpIndex			C constant
	xorOpIndex 			C constant
Used like an enum, in ST one would use symbols instead.

Class vars:
	none


History
--------

v2.0

Rewrite primitives to use 32-bits digits instead of 8-bits digits. This can fasten many operation up to 2x and multiplication up to 7x.
Since Large Integers are still variable byte object, care is taken to allocate just enough bytes to contain integer value (not necessarily a multiple of 4 bytes).
Primitives will use the extra bytes beyond necessary bytes up to next multiple of 4, so it's mandatory that those extra bytes be correctly set to zero
At image side, digits are still 8-bits so that fallback code involve only SmallInteger.

Primitives assume that byte ordering (endianness) is allways little endian, because LargeIntegers remain regular byte Objects.
On (hypothetic) big endian machines, conversion is performed at fetch/store time thru usage of dedicated macro.

v1.5

- no code change at all compared to v1.4
- made to outsource testing code (LargeIntegersPluginTest) introduced in earlier versions
- updated class comment: reference to LargeIntegersPluginTest removed

v1.4

- no semantic change compared to v1.3
- >>cHighBit: improved (could be faster now)
- fix: class comment
- improved class comment
- >>flag: introduced to allow #flag: messages (does nothing)
- new: class>>buildCodeGeneratorUpTo: as hook for switching debugMode (default is not to change anything)
- removed: class>>new (obsolete)
- minor cleanup of source code layout

v1.3

- fix: >>primDigitDiv:negative: now checks if its Integer args are normalized; without this change the plugin crashes, if a division by zero through a non normalized - filled with zero bytes - arg occurs. This can happen through printing by the inspector windows after changing the bytes of a LargeInteger manually.

v1.2

- fix: >>anyBitOfBytes: aBytesOop from: start to: stopArg

v1.1

- >>primGetModuleName for checking the version of the plugin;

- >>primDigitBitShiftMagnitude and >>primAnyBitFrom:to: for supporting - not installing! - unification of shift semantics of negative Integers;

v1.0

- speeds up digitDiv:neg: at about 20%.
	In >>cCoreDigitDivDiv:len:rem:len:quo:len: the 'nibble' arithmetic is removed.
