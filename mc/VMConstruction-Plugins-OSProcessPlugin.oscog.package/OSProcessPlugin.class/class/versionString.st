version identification
versionString
	"Version numbering is independent of OSProcess class>>versionString, and should be
	changed only when the plugin changes. Version numbers will begin arbitrarily
	with 2.1 as of OSProcess 2.7. See the instance side version of this method for the
	implementation.

	Important: When this method is changed, the instance side method must also be
	changed to match."

	"OSProcessPlugin versionString"

	"4.0 supports 64bit code base"

	^ '4.3.3 Cog'
