package curses.py;

import python.Tuple;

@:enum abstract YESBOOL(Int) to Int{
	var YES = 1;
	var NO = 0;
}

@:pythonImport("curses")
@:native("curses.Window")
@:final extern class Window{

	@:overload(function(ch:Int, ?attr:Int):Void{})
	public function addch(y:Int, x:Int, ch:Int, ?attr:Int):Void;
	/* Note A character means a C character (an ASCII code), rather than a Python character (a string of length 1). (This note is true whenever the documentation mentions a character.) The built-in ord() is handy for conveying strings to codes. */
	/* Paint character ch at (y, x) with attributes attr, overwriting any character previously painter at that location. By default, the character position and attributes are the current settings for the window object. */

	@:overload(function(str:String, n:Int, ?attr:Int):Void{})
	public function addnstr(y:Int, x:Int, str:String, n:Int, attr:Int):Void;
	/* Paint at most n characters of the string str at (y, x) with attributes attr, overwriting anything previously on the display. */

	@:overload(function(y:Int, x:Int, str:String, ?attr:Int):Void{})
	public function addstr(str:String, attr:Int):Void;
	/* Paint the string str at (y, x) with attributes attr, overwriting anything previously on the display. */
	public inline function str(y:Int, x:Int, str:String, ?attr:Int):Void{
		this.addstr(y, x, str, attr);
	}

	public function attroff(attr:Int):Void;
	/* Remove attribute attr from the “background” set applied to all writes to the current window. */

	public function attron(attr:Int):Void;
	/* Add attribute attr from the “background” set applied to all writes to the current window. */

	public function attrset(attr:Int):Void;
	/* Set the “background” set of attributes to attr. This set is initially 0 (no attributes). */

	public function bkgd(ch:Int, ?attr:Int):Void;
	/* Set the background property of the window to the character ch, with attributes attr. The change is then applied to every character position in that window: */
	/* The attribute of every character in the window is changed to the new background attribute. */
	/* Wherever the former background character appears, it is changed to the new background character. */

	public function bkgdset(ch:Int, ?attr:Int):Void;
	/* Set the window’s background. A window’s background consists of a character and any combination of attributes. The attribute part of the background is combined (OR’ed) with all non-blank characters that are written into the window. Both the character and attribute parts of the background are combined with the blank characters. The background becomes a property of the character and moves with the character through any scrolling and insert/delete line/character operations. */

	public function border(?ls:Int, ?rs:Int, ts:Int, ?bs:Int, ?tl:Int, ?tr:Int, ?bl:Int, ?br:Int):Void;
	/* Draw a border around the edges of the window. Each parameter specifies the character to use for a specific part of the border; see the table below for more details. The characters can be specified as integers or as one-character strings. */

	/* Note A 0 value for any parameter will cause the default character to be used for that parameter. Keyword parameters can not be used. The defaults are listed in this table: */
	/* Parameter	Description	Default value
	ls	Left side	ACS_VLINE
	rs	Right side	ACS_VLINE
	ts	Top	ACS_HLINE
	bs	Bottom	ACS_HLINE
	tl	Upper-left corner	ACS_ULCORNER
	tr	Upper-right corner	ACS_URCORNER
	bl	Bottom-left corner	ACS_LLCORNER
	br	Bottom-right corner	ACS_LRCORNER */

	@:overload(function():Void{})
	public function box(vertch:Int, horch:Int):Void;
	/* Similar to border(), but both ls and rs are vertch and both ts and bs are horch. The default corner characters are always used by this function. */

	@:overload(function(attr:Int):Void{})
	@:overload(function(num:Int, attr:Int):Void{})
	@:overload(function(y:Int, x:Int, attr:Int):Void{})
	public function chgat(y:Int, x:Int, num:Int, attr:Int):Void;
	/* Set the attributes of num characters at the current cursor position, or at position (y, x) if supplied. If no value of num is given or num = -1, the attribute will be set on all the characters to the end of the line. This function does not move the cursor. The changed line will be touched using the touchline() method so that the contents will be redisplayed by the next window refresh. */

	public function clear():Void;
	/* Like erase(), but also cause the whole window to be repainted upon next call to refresh(). */

	public function clearok(yes:YESBOOL):Void;
	/* If yes is 1, the next call to refresh() will clear the window completely. */

	public function clrtobot():Void;
	/* Erase from cursor to the end of the window: all lines below the cursor are deleted, and then the equivalent of clrtoeol() is performed. */

	public function clrtoeol():Void;
	/* Erase from cursor to the end of the line. */

	public function cursyncup():Void;
	/* Update the current cursor position of all the ancestors of the window to reflect the current cursor position of the window. */

	public function delch(y:Int, x:Int):Void;
	/* Delete any character at (y, x). */

	public function deleteln():Void;
	/* Delete the line under the cursor. All following lines are moved up by one line. */

	@:overload(function(begin_y:Int, begin_x:Int):Window{})
	public function derwin(nlines:Int, ncols:Int, begin_y:Int, begin_x:Int):Window;
	/* An abbreviation for “derive window”, derwin() is the same as calling subwin(), except that begin_y and begin_x are relative to the origin of the window, rather than relative to the entire screen. Return a window object for the derived window. */

	public function echochar(ch:Int, ?attr:Int):Void;
	/* Add character ch with attribute attr, and immediately call refresh() on the window. */

	public function enclose(y:Int, x:Int):Bool;
	/* Test whether the given pair of screen-relative character-cell coordinates are enclosed by the given window, returning True or False. It is useful for determining what subset of the screen windows enclose the location of a mouse event. */

	public function encoding():String;
	/* Encoding used to encode method arguments (Unicode strings and characters). The encoding attribute is inherited from the parent window when a subwindow is created, for example with window.subwin(). By default, the locale encoding is used (see locale.getpreferredencoding()). */
	/* New in version 3.3. */

	public function erase():Void;
	/* Clear the window. */

	public function getbegyx():Tuple2<Int,Int>;
	/* Return a tuple (y, x) of co-ordinates of upper-left corner. */

	public function getbkgd():Tuple2<Int,Int>;
	/* Return the given window’s current background character/attribute pair. */

	public function getch(y:Int, x:Int):Int;
	/* Get a character. Note that the integer returned does not have to be in ASCII range: function keys, keypad keys and so on return numbers higher than 256. In no-delay mode, -1 is returned if there is no input, else getch() waits until a key is pressed. */

	public function get_wch(y:Int, x:Int):Int;
	/* Get a wide character. Return a character for most keys, or an integer for function keys, keypad keys, and other special keys. */
	/* New in version 3.3. */

	public function getkey(y:Int, x:Int):String;
	/* Get a character, returning a string instead of an integer, as getch() does. Function keys, keypad keys and other special keys return a multibyte string containing the key name. In no-delay mode, an exception is raised if there is no input. */

	public function getmaxyx():Tuple2<Int,Int>;
	/* Return a tuple (y, x) of the height and width of the window. */

	public function getparyx():Tuple2<Int,Int>;
	/* Return the beginning coordinates of this window relative to its parent window into two integer variables y and x. Return -1, -1 if this window has no parent. */

	public function getstr(y:Int, x:Int):String;
	/* Read a string from the user, with primitive line editing capacity. */

	public function getyx():Tuple2<Int,Int>;
	/* Return a tuple (y, x) of current cursor position relative to the window’s upper-left corner. */

	@:overload(function(ch:Int, n:Int):Void{})
	public function hline(y:Int, x:Int, ch:Int, n:Int):Void;
	/* Display a horizontal line starting at (y, x) with length n consisting of the character ch. */

	public function idcok(flag:Bool):Void;
	/* If flag is False, curses no longer considers using the hardware insert/delete character feature of the terminal; if flag is True, use of character insertion and deletion is enabled. When curses is first initialized, use of character insert/delete is enabled by default. */

	public function idlok(yes:YESBOOL):Void;
	/* If called with yes equal to 1, curses will try and use hardware line editing facilities. Otherwise, line insertion/deletion are disabled. */

	public function immedok(flag:Bool):Void;
	/* If flag is True, any change in the window image automatically causes the window to be refreshed; you no longer have to call refresh() yourself. However, it may degrade performance considerably, due to repeated calls to wrefresh. This option is disabled by default. */

	public function inch(y:Int, x:Int):Int;
	/* Return the character at the given position in the window. The bottom 8 bits are the character proper, and upper bits are the attributes. */

	@:overload(function(ch:Int, attr:Int):Void{})
	public function insch(y:Int, x:Int, ch:Int, attr:Int):Void;
	/* Paint character ch at (y, x) with attributes attr, moving the line from position x right by one character. */

	public function insdelln(nlines:Int):Void;
	/* Insert nlines lines into the specified window above the current line. The nlines bottom lines are lost. For negative nlines, delete nlines lines starting with the one under the cursor, and move the remaining lines up. The bottom nlines lines are cleared. The current cursor position remains the same. */

	public function insertln():Void;
	/* Insert a blank line under the cursor. All following lines are moved down by one line. */

	@:overload(function(str:String, n:Int, ?attr:Int):Void{})
	public function insnstr(y:Int, x:Int, str:String, n:Int, ?attr:Int):Void;
	/* Insert a character string (as many characters as will fit on the line) before the character under the cursor, up to n characters. If n is zero or negative, the entire string is inserted. All characters to the right of the cursor are shifted right, with the rightmost characters on the line being lost. The cursor position does not change (after moving to y, x, if specified). */

	@:overload(function(str:String, ?attr:Int):Void{})
	public function insstr(y:Int, x:Int, str:String, ?attr:Int):Void;
	/* Insert a character string (as many characters as will fit on the line) before the character under the cursor. All characters to the right of the cursor are shifted right, with the rightmost characters on the line being lost. The cursor position does not change (after moving to y, x, if specified). */

	@:overload(function(n:Int):String{})
	public function instr(y:Int, x:Int, n:Int):String;
	/* Return a string of characters, extracted from the window starting at the current cursor position, or at y, x if specified. Attributes are stripped from the characters. If n is specified, instr() returns a string at most n characters long (exclusive of the trailing NUL). */

	public function is_linetouched(line:Int):Bool;
	/* Return True if the specified line was modified since the last call to refresh(); otherwise return False. Raise a curses.error exception if line is not valid for the given window. */

	public function is_wintouched():Bool;
	/* Return True if the specified window was modified since the last call to refresh(); otherwise return False. */

	public function keypad(yes:YESBOOL):Void;
	/* If yes is 1, escape sequences generated by some keys (keypad, function keys) will be interpreted by curses. If yes is 0, escape sequences will be left as is in the input stream. */

	public function leaveok(yes:YESBOOL):Void;
	/* If yes is 1, cursor is left where it is on update, instead of being at “cursor position.” This reduces cursor movement where possible. If possible the cursor will be made invisible. */
	/* If yes is 0, cursor will always be at “cursor position” after an update. */

	public function move(new_y:Int, new_x:Int):Void;
	/* Move cursor to (new_y, new_x). */

	public function mvderwin(y:Int, x:Int):Void;
	/* Move the window inside its parent window. The screen-relative parameters of the window are not changed. This routine is used to display different parts of the parent window at the same physical position on the screen. */

	public function mvwin(new_y:Int, new_x:Int):Void;
	/* Move the window so its upper-left corner is at (new_y, new_x). */

	public function nodelay(yes:YESBOOL):Void;
	/* If yes is 1, getch() will be non-blocking. */

	public function notimeout(yes:YESBOOL):Void;
	/* If yes is 1, escape sequences will not be timed out. */
	/* If yes is 0, after a few milliseconds, an escape sequence will not be interpreted, and will be left in the input stream as is. */

	public function noutrefresh():Void;
	/* Mark for refresh but wait. This function updates the data structure representing the desired state of the window, but does not force an update of the physical screen. To accomplish that, call doupdate(). */

	@:overload(function(destwin:Window):Void{})
	public function overlay(destwin:Window, sminrow:Int, smincol:Int, dminrow:Int, dmincol:Int, dmaxrow:Int, dmaxcol:Int):Void;
	/* Overlay the window on top of destwin. The windows need not be the same size, only the overlapping region is copied. This copy is non-destructive, which means that the current background character does not overwrite the old contents of destwin. */
	/* To get fine-grained control over the copied region, the second form of overlay() can be used. sminrow and smincol are the upper-left coordinates of the source window, and the other variables mark a rectangle in the destination window. */

	@:overload(function(destwin:Window):Void{})
	public function overwrite(destwin:Window, sminrow:Int, smincol:Int, dminrow:Int, dmincol:Int, dmaxrow:Int, dmaxcol:Int):Void;
	/* Overwrite the window on top of destwin. The windows need not be the same size, in which case only the overlapping region is copied. This copy is destructive, which means that the current background character overwrites the old contents of destwin. */

	/* To get fine-grained control over the copied region, the second form of overwrite() can be used. sminrow and smincol are the upper-left coordinates of the source window, the other variables mark a rectangle in the destination window. */

	public function putwin(file:python.lib.FileObject):Void;
	/* Write all data associated with the window into the provided file object. This information can be later retrieved using the getwin() function. */

	public function redrawln(beg:Int, num:Int):Void;
	/* Indicate that the num screen lines, starting at line beg, are corrupted and should be completely redrawn on the next refresh() call. */

	public function redrawwin():Void;
	/* Touch the entire window, causing it to be completely redrawn on the next refresh() call. */

	@:overload(function():Void{})
	public function refresh(pminrow:Int, pmincol:Int, sminrow:Int, smincol:Int, smaxrow:Int, smaxcol:Int):Void;
	/* Update the display immediately (sync actual screen with previous drawing/deleting methods). */
	/* The 6 optional arguments can only be specified when the window is a pad created with newpad(). The additional parameters are needed to indicate what part of the pad and screen are involved. pminrow and pmincol specify the upper left-hand corner of the rectangle to be displayed in the pad. sminrow, smincol, smaxrow, and smaxcol specify the edges of the rectangle to be displayed on the screen. The lower right-hand corner of the rectangle to be displayed in the pad is calculated from the screen coordinates, since the rectangles must be the same size. Both rectangles must be entirely contained within their respective structures. Negative values of pminrow, pmincol, sminrow, or smincol are treated as if they were zero. */

	public function resize(nlines:Int, ncols:Int):Void;
	/* Reallocate storage for a curses window to adjust its dimensions to the specified values. If either dimension is larger than the current values, the window’s data is filled with blanks that have the current background rendition (as set by bkgdset()) merged into them. */

	public function scroll(lines:Int=1):Void;
	/* Scroll the screen or scrolling region upward by lines lines. */

	public function scrollok(flag:Bool):Void;
	/* Control what happens when the cursor of a window is moved off the edge of the window or scrolling region, either as a result of a newline action on the bottom line, or typing the last character of the last line. If flag is false, the cursor is left on the bottom line. If flag is true, the window is scrolled up one line. Note that in order to get the physical scrolling effect on the terminal, it is also necessary to call idlok(). */

	public function setscrreg(top:Int, bottom:Int):Void;
	/* Set the scrolling region from line top to line bottom. All scrolling actions will take place in this region. */

	public function standend():Void;
	/* Turn off the standout attribute. On some terminals this has the side effect of turning off all attributes. */

	public function standout():Void;
	/* Turn on attribute A_STANDOUT. */

	@:overload(function(begin_y:Int, begin_x:Int):Window{})
	public function subpad(nlines:Int, ncols:Int, begin_y:Int, begin_x:Int):Window;
	/* Return a sub-window, whose upper-left corner is at (begin_y, begin_x), and whose width/height is ncols/nlines. */

	@:overload(function(begin_y:Int, begin_x:Int):Window{})
	public function subwin(nlines:Int, ncols:Int, begin_y:Int, begin_x:Int):Window;
	/* Return a sub-window, whose upper-left corner is at (begin_y, begin_x), and whose width/height is ncols/nlines. */
	/* By default, the sub-window will extend from the specified position to the lower right corner of the window. */

	public function syncdown():Void;
	/* Touch each location in the window that has been touched in any of its ancestor windows. This routine is called by refresh(), so it should almost never be necessary to call it manually. */

	public function syncok(flag:Bool):Void;
	/* If called with flag set to True, then syncup() is called automatically whenever there is a change in the window. */

	public function syncup():Void;
	/* Touch all locations in ancestors of the window that have been changed in the window. */

	public function timeout(delay:Int):Void;
	/* Set blocking or non-blocking read behavior for the window. If delay is negative, blocking read is used (which will wait indefinitely for input). If delay is zero, then non-blocking read is used, and -1 will be returned by getch() if no input is waiting. If delay is positive, then getch() will block for delay milliseconds, and return -1 if there is still no input at the end of that time. */

	public function touchline(start:Int, count:Int, changed:Int):Void;
	/* Pretend count lines have been changed, starting with line start. If changed is supplied, it specifies whether the affected lines are marked as having been changed (changed=1) or unchanged (changed=0). */

	public function touchwin():Void;
	/* Pretend the whole window has been changed, for purposes of drawing optimizations. */

	public function untouchwin():Void;
	/* Mark all lines in the window as unchanged since the last call to refresh(). */

	@:overload(function(ch:Int, n:Int):Void{})
	public function vline(y:Int, x:Int, ch:Int, n:Int):Void;
	/* Display a vertical line starting at (y, x) with length n consisting of the character ch. */

}
