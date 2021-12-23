<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE article>



<!--
A pandoc template for docbook output.

Copyright (C) 2021 Ralf Stephan (RaSt) <me@ralf-stephan.name>

RaSt mod_ecl is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either  version 3 of the  License, or (at your  option) any later
version.

RaSt mod_ecl is distributed  in the hope that it will  be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR  A PARTICULAR  PURPOSE.   See the  GNU General  Public  License for  more
details.

You should have received a copy of  the GNU General Public License along with
this     program     in     the     file    COPYING.      If     not,     see
<https://www.gnu.org/licenses/>.
-->



<article
$if(lang)$
  xml:lang="$lang$"
$endif$
  xmlns="http://docbook.org/ns/docbook" version="5.0"
$if(mathml)$
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
$endif$
  xmlns:xlink="http://www.w3.org/1999/xlink" >
  <info>
    <title>$title$</title>
$if(subtitle)$
    <subtitle>$subtitle$</subtitle>
$endif$
$if(author)$
    <authorgroup>
$for(author)$
      <author>
        $author$
      </author>
$endfor$
    </authorgroup>
$endif$
$if(date)$
    <date>$date$</date>
$endif$
  </info>
$for(include-before)$
  $include-before$
$endfor$
  $body$
$for(include-after)$
  $include-after$
$endfor$
</article>
