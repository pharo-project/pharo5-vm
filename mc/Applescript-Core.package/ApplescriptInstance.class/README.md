I represent an Applescript Scripting Component, derived from the Component Manager.  For more information about Scripting Components, see Inside Macintosh: Interapplication Communications, at:

	http://developer.apple.com/techpubs/mac/IAC/IAC-2.html.

Essentially, I represent a record comprising a one-word handle to the scripting component. That handle is passed as a matter of course to almost every important Applescript call.  Accordingly, I am also the repository for most of the primitives for the Applescript/Squeak interface.