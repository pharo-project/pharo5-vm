sample scripts
dialogWithUTF16
	"display dialog using Unicode
		Applescript dialogWithUTF16
	"
	| ba bs st macName |
	ba := #(254 255 0 16r28 16r5B 16r5D 16r7D 16rEC 0 16r29 0 10) asByteArray.
	bs := ba asString.
	st := (StandardFileStream newFileNamed: '/tmp/testUTF16') binary.
	st nextPutAll: bs.
	st close.
	macName := Applescript unixToMacFilename: '/tmp/testUTF16'.
	Applescript doIt:'
	set f to open for access "', macName, '"
	set myText to (read f as Unicode text)
	display dialog "Classic of Filiality " & myText
	close access f'