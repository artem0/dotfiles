on run {input, parameters}
	tell applicaation "Finder"
		set dir_path to quoted form of (POSIX path of (folder of the front window as alias))
	end tell
	CD_to(dir_path)
end run

on CD_to(theDir)
	tell application "iTerm"
		activate
		set win to (create window with default profile)
		set sesh to (current session of win)
		tell sesh to write text "cd " & theDir & ";clear"
	end tell
end CD_to
