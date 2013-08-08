sample scripts
sillyDialog
	"A silly Apple GUI demo
		Applescript sillyDialog
	"
	self doIt: '
display dialog "Enter a number between 1 and 10." default answer ""
set userValue to {text returned of result} as real
if (userValue < 1) or (userValue > 10) then
	display dialog "That Value is out of range." buttons {"OK"} default button 1
else 
	display dialog "Thanks for playing." buttons {"OK"} default button 1
end if'


