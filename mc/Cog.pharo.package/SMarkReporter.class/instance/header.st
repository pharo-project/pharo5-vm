reporting
header
	| suiteName |
	suiteName := runner suite class name asString.
	stream << 'Report for: ' << suiteName; cr.