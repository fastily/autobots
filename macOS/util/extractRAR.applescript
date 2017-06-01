(*
 * Uses the UI to select a RAR file for extraction.
 * 
 * PRECONDITIONS: 
 *	1) unrar is installed.
 *
 * Tested on macOS 10.12.5
 * Author: Fastily
 *)

set targetFile to choose file with prompt "Please choose a file:" of type {"RAR"}
do shell script "cd \"$( dirname '" & POSIX path of targetFile & "')\"; PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin unrar x '" & POSIX path of targetFile & "'"

display notification "All Done!" with title "extractRAR"