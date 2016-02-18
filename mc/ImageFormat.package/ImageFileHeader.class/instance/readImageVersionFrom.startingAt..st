reading
readImageVersionFrom: aStream startingAt: imageOffset
	"Look for image format in the next 4 or 8 bytes and set imageFormat. Answer true
	if the header is written in little endian format."

	(aStream nextNumber: 4) caseOf:
		{
			[ 16r00001966 "6502" ] -> [ imageFormat := ImageFormat fromInteger: 6502. ^false ] .
			[ 16r66190000 "6502" ] -> [ imageFormat := ImageFormat fromInteger: 6502. ^true ] .
			[ 16r00001968 "6504" ] -> [ imageFormat := ImageFormat fromInteger: 6504. ^false ] .
			[ 16r68190000 "6504" ] -> [ imageFormat := ImageFormat fromInteger: 6504. ^true ] .
			[ 16r00001969 "6505" ] -> [ imageFormat := ImageFormat fromInteger: 6505. ^false ] .
			[ 16r69190000 "6505" ] -> [ imageFormat := ImageFormat fromInteger: 6505. ^true ] .
			[ 16r00001979 "6521" ] -> [ imageFormat := ImageFormat fromInteger: 6521. ^false ] .
			[ 16r79190000 "6521" ] -> [ imageFormat := ImageFormat fromInteger: 6521. ^true ] .
			[ 16rA0090100 "68000" ] -> [ imageFormat := ImageFormat fromInteger: 68000. aStream next: 4. ^true ] .
			[ 16rA2090100 "68002" ] -> [ imageFormat := ImageFormat fromInteger: 68002. aStream next: 4. ^true ] .
			[ 16rA3090100 "68003" ] -> [ imageFormat := ImageFormat fromInteger: 68003. aStream next: 4. ^true ] .
			[ 16rB3090100 "68019" ] -> [ imageFormat := ImageFormat fromInteger: 68019. aStream next: 4. ^true ] .
			[ 16r00000000 ] -> [
				(aStream nextNumber: 4) caseOf: {
					[ 16r000109A0 "68000" ] -> [ imageFormat := ImageFormat fromInteger: 68000. ^false ] .
					[ 16r000109A2 "68002" ] -> [ imageFormat := ImageFormat fromInteger: 68002. ^false ] .
					[ 16r000109A3 "68003" ] -> [ imageFormat := ImageFormat fromInteger: 68003. ^false ] .
					[ 16r000109B3 "68019" ] -> [ imageFormat := ImageFormat fromInteger: 68019. ^false ] .
				} otherwise: [self error: self asString , ' unrecognized format number']
			]
		} otherwise: [self error: self asString , ' unrecognized format number']
	
	"ImageFormat versionNumberByteArrays do: [:e |
		Transcript cr; show: e printString , ': ', (ImageFormat fromBytes: e) description]
	
#[0 0 25 102]: A 32-bit image with no closure support and no native platform float word order requirement (6502)
#[102 25 0 0]: A 32-bit image with no closure support and no native platform float word order requirement (6502)
#[0 0 25 104]: A 32-bit image with closure support and no native platform float word order requirement (6504)
#[104 25 0 0]: A 32-bit image with closure support and no native platform float word order requirement (6504)
#[0 0 0 0 0 1 9 160]: A 64-bit image with no closure support and no native platform float word order requirement (68000)
#[160 9 1 0 0 0 0 0]: A 64-bit image with no closure support and no native platform float word order requirement (68000)
#[0 0 0 0 0 1 9 162]: A 64-bit image with closure support and no native platform float word order requirement (68002)
#[162 9 1 0 0 0 0 0]: A 64-bit image with closure support and no native platform float word order requirement (68002)
#[0 0 25 105]: A 32-bit image with closure support and float words stored in native platform order (6505)
#[105 25 0 0]: A 32-bit image with closure support and float words stored in native platform order (6505)
#[0 0 0 0 0 1 9 163]: A 64-bit mage with closure support and float words stored in native platform order (68003)
#[163 9 1 0 0 0 0 0]: A 64-bit image with closure support and float words stored in native platform order (68003)
	
	"
	