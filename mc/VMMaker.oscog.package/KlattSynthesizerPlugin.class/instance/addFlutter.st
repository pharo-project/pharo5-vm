processing-voice
addFlutter
	"Add F0 flutter, as specified in:
		'Analysis, synthesis and perception of voice quality variations among
		female and male talkers' D.H. Klatt and L.C. Klatt JASA 87(2) February 1990.
	Flutter is added by applying a quasi-random element constructed from three
	slowly varying sine waves."
	| timeCount asin bsin csin deltaF0 |
	<returnTypeC: 'void'>
	<var: 'timeCount' type: 'float '>
	<var: 'asin' type: 'float '>
	<var: 'bsin' type: 'float '>
	<var: 'csin' type: 'float '>
	<var: 'deltaF0' type: 'double '>
	timeCount := (self cCoerce: samplesCount to: 'float') / (self cCoerce: samplingRate to: 'float').
	asin := (2.0 * PI * 12.7 * timeCount) sin.
	bsin := (2.0 * PI * 7.1 * timeCount) sin.
	csin := (2.0 * PI * 4.7 * timeCount) sin.
	deltaF0 := (frame at: Flutter) * 2.0 * (frame at: F0) / 100.0 * (asin + bsin + csin).
	pitch := pitch + deltaF0