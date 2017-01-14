Pragmatizer is a utility for converting message send directives (such as 'self inline: true') to their corresponding pragma implementations (<inline: true>) in method source.

The #depragmatize method provides a means for reverting to message send directives. This may be useful in the event of needing to load VMMaker into an image that does not support pragmas.

This is based on an original script provided by Eliot Miranda.