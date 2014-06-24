initialize-release
bitAssignments

	"ImageFormat bitAssignments
		doWithIndex: [ :e :i | Transcript cr; show: 'bit ', i asString, ' is ', (e ifNil: ['unused'])]"

	| bits |
	bits := Array new: 32.
		"If bit 1 is set, the high and low order 32-bit words of a Float are stored in
		platform word order. If bit 1 is not set, big-endian word order is used for Float
		regardless of the platform." 
	bits at: 1 put: 'the use platform float word order bit (Cog and StackInterpreter)'.
	bits at: 2 put: 'used in base version numbers'.
	bits at: 3 put: 'used in base version numbers'.
	bits at: 4 put: 'used in base version numbers'.
	bits at: 5 put: 'the Spur object format bit'.
	bits at: 6 put: 'used in base version numbers'.
	bits at: 7 put: 'used in base version numbers'.
	bits at: 8 put: 'used in base version numbers'.
	bits at: 9 put: 'used in base version numbers'.
	bits at: 10 put: nil.	"unassigned bit available for future image formats"
	bits at: 11 put: nil.	"unassigned bit available for future image formats"
	bits at: 12 put: 'used in base version numbers'.
	bits at: 13 put: 'used in base version numbers'.
	bits at: 14 put: nil.	"unassigned bit available for future image formats"
	bits at: 15 put: nil.	"unassigned bit available for future image formats"
	bits at: 16 put: nil.	"unassigned bit available for future image formats"
	bits at: 17 put: 'used in base version numbers'.
	bits at: 18 put: nil.	"unassigned bit available for future image formats"
	bits at: 19 put: nil.	"unassigned bit available for future image formats"
	bits at: 20 put: nil.	"unassigned bit available for future image formats"
	bits at: 21 put: nil.	"unassigned bit available for future image formats"
	bits at: 22 put: nil.	"unassigned bit available for future image formats"
	bits at: 23 put: nil.	"unassigned bit available for future image formats"
	bits at: 24 put: nil.	"unassigned bit available for future image formats"
	bits at: 25 put: nil.	"unassigned bit available for future image formats"
	bits at: 26 put: nil.	"unassigned bit available for future image formats"
	bits at: 27 put: nil.	"unassigned bit available for future image formats"
	bits at: 28 put: nil.	"unassigned bit available for future image formats"
	bits at: 29 put: nil.	"unassigned bit available for future image formats"
	bits at: 30 put: nil.	"unassigned bit available for future image formats"
	bits at: 31 put: nil.	"unassigned bit available for future image formats"
		"If bit 32 is set, additional image format information will be stored in one or
		more additional words. Currently this is unused, and bit 32 is always zero."
	bits at: 32 put: 'the extension bit (reserved for future use)'.
	^bits
