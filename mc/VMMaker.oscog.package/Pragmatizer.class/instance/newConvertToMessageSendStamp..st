method stamp
newConvertToMessageSendStamp: oldStamp
	"Insert a comment in a method stamp to indicate that conversion from pragmas to old
	style message sends was done. If stampCutString has been set, remove this substring
	from the oldStamp prior to adding a new substring. If stampInsertString was set, use
	this as the substring to insert. Otherwise add a substring with current date and author
	initials." 

	| newStamp |
	stampCutString
		ifNil: [newStamp := oldStamp]
		ifNotNil: [newStamp := oldStamp copyReplaceAll: stampCutString with: ''].
	stampInsertString
		ifNil: [newStamp := newStamp
						copyReplaceFrom: (oldStamp indexOf: Character space) + 1
						to: (oldStamp indexOf: Character space)
						with: '(remove pragmas ', Utilities authorInitials, ' ', Date today yyyymmdd, ') ']
		ifNotNil: [newStamp := newStamp
						copyReplaceFrom: (oldStamp indexOf: Character space) + 1
						to: (oldStamp indexOf: Character space)
						with: stampInsertString].
	^ newStamp
