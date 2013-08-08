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
