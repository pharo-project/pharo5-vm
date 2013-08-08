sample scripts
playQT4Movie
	"Demonstrate Access to Quicktime
		Applescript playQT4Movie
	"
	"for 3.8 compatibility delete all line continuation characters (value: 194)"

	^Applescript doIt: '-- Play QuickTime File
-- ¬©1999 Sal Soghoian, Apple Computer

property source_folder : ""
property container_kind : "folder"
property reset_string : "Pick New Source Folder"

-- Check the version of QuickTime
copy my gestaltVersion_info("qtim", 8) to {QT_version, QT_string}
if the QT_version is less than "0400" then
	display dialog "This script requires QuickTime 4.0 or higher." & return & return & "The currently installed version is: " & QT_string buttons {"Cancel"} default button 1
end if

-- Check the version of the OS
copy my gestaltVersion_info("sysv", 4) to {system_version, system_string}
if the system_version is less than "0850" then
	display dialog "This script requires Mac OS 8.5 or higher." & return & return & "The currently installed version is: " & system_string buttons {"Cancel"} default button 1
end if

-- check to see if source folder exists
try
	if the source_folder is "" then error
	set the source_folder to alias (source_folder as text)
on error
	set the source_folder to choose_source_folder()
	if the result is false then return "user canceled"
end try

-- set the target folder to the source folder
set the target_folder to the source_folder

repeat
	-- search the target folder for folders or QT files 
	try
		tell application "Finder"
			set the item_list to (the name of every item of the target_folder whose (creator type is "TVOD") or (kind is the container_kind)) as list
			set the item_list to my ASCII_Sort(item_list)
			set the beginning of the item_list to "Pick New Source Folder"
		end tell
	on error error_message number error_number
		beep
		--display dialog error_message
		display dialog "The chosen folder contains no folders or QuickTime files." buttons {"Show Me", "Cancel"} default button 2
		tell application "Finder"
			activate
			open the target_folder
		end tell
		return "no items"
	end try
	
	-- prompt the user to pick a folder or file
	set the chosen_item to choose from list the item_list with prompt "Pick an item:"
	if the chosen_item is false then return
	set the chosen_item to the chosen_item as string
	
	if the chosen_item is reset_string then
		set the source_folder to choose_source_folder()
		if the result is false then return "user canceled"
		set the target_folder to the source_folder
	else
		-- Check the user''s choice to determine whether it''s a file or folder
		tell application "Finder"
			if the kind of item chosen_item of the target_folder is the container_kind then
				-- The user picked a folder. Set the new target folder and repeat the process.
				set the target_folder to folder chosen_item of the the target_folder
			else
				-- The user picked a file. Get the path to the file and exit the repeat.
				set the chosen_item to (item chosen_item of the target_folder) as alias
				exit repeat
			end if
		end tell
	end if
end repeat

-- Find out if the user wants to play the item in the front or back.
set play_in_background to true
display dialog "Play the media in the foreground or background?" buttons {"Cancel", "Foreground", "Background"} default button 3
if the button returned of the result is "Foreground" then set play_in_background to false

-- Quit the QuickTime Player if it is open
--tell application "Finder"
--	if (the creator type of every process) contains ¬´class TVOD¬ª then tell application "QuickTime Player" to quit end tell
--end tell

-- Convert the alias to a URL format string
set this_file to "file:///" & my filepath_to_URL(the chosen_item, true, false)

-- Tell the QuickTime Player to open the file.
-- NOTE: to autoplay, Check the Auto-Play preference in the General setting in the QuickTime Player.
tell application "QuickTime Player"
	if play_in_background is false then activate
	open location this_file
end tell

on gestaltVersion_info(gestalt_code, string_length)
	try
		tell application "Finder" to copy my NumToHex((system attribute gestalt_code), string_length) to {a, b, c, d}
		set the numeric_version to {a, b, c, d} as string
		if a is "0" then set a to ""
		set the version_string to (a & b & "." & c & "." & d) as string
		return {numeric_version, version_string}
	on error
		return {"", "unknown"}
	end try
end gestaltVersion_info

on NumToHex(hexData, stringLength)
	set hexString to {}
	repeat with i from stringLength to 1 by -1
		set hexString to ((hexData mod 16) as string) & hexString
		set hexData to hexData div 16
	end repeat
	return (hexString as string)
end NumToHex

on choose_source_folder()
	try
		set the source_folder to choose folder with prompt "Pick a folder containing Quicktime content:"
		return the source_folder
	on error
		return false
	end try
end choose_source_folder

-- this sub-routine converts a filepath to an encoded URL
-- My Disk:My Folder:My File
-- My%20Disk/My%20Folder/My%20File
on filepath_to_URL(this_file, encode_URL_A, encode_URL_B)
	set this_file to this_file as text
	set AppleScript''s text item delimiters to ":"
	set the path_segments to every text item of this_file
	repeat with i from 1 to the count of the path_segments
		set this_segment to item i of the path_segments
		set item i of the path_segments to my encode_text(this_segment, encode_URL_A, encode_URL_B)
	end repeat
	set AppleScript''s text item delimiters to "/"
	set this_file to the path_segments as string
	set AppleScript''s text item delimiters to ""
	return this_file
end filepath_to_URL

-- this sub-routine is used to encode text
on encode_text(this_text, encode_URL_A, encode_URL_B)
	set the standard_characters to "abcdefghijklmnopqrstuvwxyz0123456789"
	set the URL_A_chars to "$+!''/?;&@=#%><{}[]\"~`^\\|*"
	set the URL_B_chars to ".-_:"
	set the acceptable_characters to the standard_characters
	if encode_URL_A is false then set the acceptable_characters to the acceptable_characters & the URL_A_chars
	if encode_URL_B is false then set the acceptable_characters to the acceptable_characters & the URL_B_chars
	set the encoded_text to ""
	repeat with this_char in this_text
		if this_char is in the acceptable_characters then
			set the encoded_text to (the encoded_text & this_char)
		else
			set the encoded_text to (the encoded_text & encode_char(this_char)) as string
		end if
	end repeat
	return the encoded_text
end encode_text

-- this sub-routine is used to encode a character
on encode_char(this_char)
	set the ASCII_num to (the ASCII number this_char)
	set the hex_list to {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"}
	set x to item ((ASCII_num div 16) + 1) of the hex_list
	set y to item ((ASCII_num mod 16) + 1) of the hex_list
	return ("%" & x & y) as string
end encode_char

-- This routine sorts a list of strings passed to it
on ASCII_Sort(my_list)
	set the index_list to {}
	set the sorted_list to {}
	repeat (the number of items in my_list) times
		set the low_item to ""
		repeat with i from 1 to (number of items in my_list)
			if i is not in the index_list then
				set this_item to item i of my_list as text
				if the low_item is "" then
					set the low_item to this_item
					set the low_item_index to i
				else if this_item comes before the low_item then
					set the low_item to this_item
					set the low_item_index to i
				end if
			end if
		end repeat
		set the end of sorted_list to the low_item
		set the end of the index_list to the low_item_index
	end repeat
	return the sorted_list
end ASCII_Sort'