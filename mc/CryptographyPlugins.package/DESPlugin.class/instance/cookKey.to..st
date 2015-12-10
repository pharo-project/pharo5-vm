support
cookKey: rawPtr to: cookPtr
	"preprocess the key to more useful format"

	| raw0 raw1 cook |
	<var: 'cook' declareC: 'unsigned long cook'>
	<var: 'cookPtr' declareC: 'unsigned long *cookPtr'> "32 words"
	<var: 'rawPtr' declareC: 'unsigned long *rawPtr'> "32 words"
	<var: 'raw0' declareC: 'unsigned long raw0'>
	<var: 'raw1' declareC: 'unsigned long raw1'>
	0 to: 15 do: [ :i |
		raw0 := rawPtr at: i*2.
		raw1 := rawPtr at: i*2 + 1.
		cook := (raw0 bitAnd: 16r00FC0000) << 6.
		cook := cook bitOr: (raw0 bitAnd: 16r00000FC0) << 10.
		cook := cook bitOr: (raw1 bitAnd: 16r00FC0000) >> 10.
		cook := cook bitOr: (raw1 bitAnd: 16r00000FC0) >> 6.
		cookPtr at: (i * 2) put: cook.
		cook := (raw0 bitAnd: 16r0003F000) << 12.
		cook := cook bitOr: (raw0 bitAnd: 16r0000003F) << 16.
		cook := cook bitOr: (raw1 bitAnd: 16r0003F000) >> 4.
		cook := cook bitOr: (raw1 bitAnd: 16r0000003F).
		cookPtr at: (i*2+1) put: cook.
		].

