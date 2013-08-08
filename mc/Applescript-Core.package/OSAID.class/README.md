I am an ExternalData representation of an OSAID handle.  OSAIDs are low-level representations of Applescript information stored in an active scripting component.  For further Information, see Apple's Inside Macintosh: Interapplication Communications, at

	http://developer.apple.com/techpubs/mac/IAC/IAC-2.html.

Essentially, I represent a record comprising a one-word handle for manipulation by the scripting component.  Virtually all operations are done on objects with OSAID forms.  Accordingly, text and compiled script information is reduced to AEDesc objects, and then processed into or from OSAID form for later manipulation.  The OSAID can then be "coerced" back into text or compiled script information, typically indirectly through AEDesc Objects. 