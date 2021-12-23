$-- A pandoc template for plain output.
$--
$-- Copyright (C) 2021 Ralf Stephan (RaSt) <me@ralf-stephan.name>
$--
$-- RaSt mod_ecl is free software: you can redistribute it and/or modify it under
$-- the terms of the GNU General Public License as published by the Free Software
$-- Foundation, either  version 3 of the  License, or (at your  option) any later
$-- version.
$--
$-- RaSt mod_ecl is distributed  in the hope that it will  be useful, but WITHOUT
$-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
$-- FOR  A PARTICULAR  PURPOSE.   See the  GNU General  Public  License for  more
$-- details.
$--
$-- You should have received a copy of  the GNU General Public License along with
$-- this     program     in     the     file    COPYING.      If     not,     see
$-- <https://www.gnu.org/licenses/>.
$--
$--
$--
$-- --- delimiter begin ---
$if(delimiter.enable)$
$delimiter.string/center 80 "" ""$

$endif$
$-- --- delimiter end ---
$-- --- header-includes begin ---
$if(header-includes)$
$for(header-includes)$
$header-includes$

$endfor$
$if(delimiter.enable)$
$delimiter.string/center 80 "" ""$

$endif$
$endif$
$-- --- header-includes end ---
$-- --- title begin ---
$if(title)$
$title/center 80 "" ""$

$endif$
$-- --- title end ---
$-- --- subtitle begin ---
$if(subtitle)$
$subtitle/center 80 "" ""$

$endif$
$-- --- subtitle end ---
$-- --- version begin ---
$if(version)$
$version/center 80 "" ""$

$endif$
$-- --- version end ---
$-- --- author begin ---
$for(author)$
$author/center 80 "" ""$

$endfor$
$-- --- author end ---
$-- --- date begin ---
$if(date)$
$date/center 80 "" ""$

$endif$
$-- --- date end ---
$-- --- delimiter begin ---
$if(delimiter.enable)$
$delimiter.string/center 80 "" ""$

$endif$
$-- --- delimiter end ---
$-- --- abstract begin ---
$if(abstract)$
$abstract/left 68 "      " "      "$

$if(delimiter.enable)$
$delimiter.string/center 80 "" ""$

$endif$
$endif$
$-- --- abstract end ---
$-- --- keywords begin ---
$if(keywords)$
$for(keywords)$
$keywords/left 68 "      " "      "$

$endfor$
$if(delimiter.enable)$
$delimiter.string/center 80 "" ""$

$endif$
$endif$
$-- --- keywords end ---
$-- --- include-before begin ---
$if(include-before)$
$for(include-before)$
$include-before$

$endfor$
$if(delimiter.enable)$
$delimiter.string/center 80 "" ""$

$endif$
$endif$
$-- --- include-before end ---
$-- --- toc begin ---
$if(toc)$
$if(toc-title)$
$toc-title$

$endif$
$if(table-of-contents)$
$table-of-contents$

$endif$
$if(delimiter.enable)$
$delimiter.string/center 80 "" ""$

$endif$
$endif$
$-- --- toc end ---
$-- --- body begin ---
$if(body)$
$body$

$if(delimiter.enable)$
$delimiter.string/center 80 "" ""$

$endif$
$endif$
$-- --- body end ---
$-- --- include-after begin ---
$if(include-after)$
$for(include-after)$
$include-after$

$endfor$
$if(delimiter.enable)$
$delimiter.string/center 80 "" ""$

$endif$
$endif$
$-- --- include-after end ---
$-- --- footer-includes begin ---
$if(footer-includes)$
$for(footer-includes)$
$footer-includes$

$endfor$
$if(delimiter.enable)$
$delimiter.string/center 80 "" ""$

$endif$
$endif$
$-- --- footer-includes end ---
