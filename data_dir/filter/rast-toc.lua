-- A pandoc filter for numbering the headings and to create a table of contents.
--
-- Copyright (C) 2021 Ralf Stephan (RaSt) <me@ralf-stephan.name>
--
-- RaSt mod_ecl is free software: you can redistribute it and/or modify it under
-- the terms of the GNU General Public License as published by the Free Software
-- Foundation, either  version 3 of the  License, or (at your  option) any later
-- version.
--
-- RaSt mod_ecl is distributed  in the hope that it will  be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-- FOR  A PARTICULAR  PURPOSE.   See the  GNU General  Public  License for  more
-- details.
--
-- You should have received a copy of  the GNU General Public License along with
-- this     program     in     the     file    COPYING.      If     not,     see
-- <https://www.gnu.org/licenses/>.



--                                        HTML                      | HEX       | DEC     | windows
--
-- non-breaking space or no-break space : &nbsp; &nonbreakingspace; | &#x000a0; | &#160;  | [ALT] [2] [5] [5]
-- em space                             : &emsp;                    | &#x02003; | &#8195; | Windonws Programm 'Zeichentabelle'
-- en space                             : &ensp;                    | &#x02002; | &#8194; |
-- zero width joiner                    : &zwj;                     | &#x0200d; | &#8205; |
-- zero width none joiner               : &zwnj;                    | &#x0200c; | &#8204; |



-- \brief The rast-toc filter constants and variables.
--
-- \details

local storage = {

  -- \brief The headers.
  --
  -- \details This contains the information about each header.
  --
  -- associative array of associative array
  --
  -- headers[1] = {identifier = 'chapter-a', level = 1, enumeration = '1',     text = 'Chapter A'}
  -- headers[2] = {identifier = 'chapter-b', level = 2, enumeration = '1.1',   text = 'Chapter B'}
  -- headers[3] = {identifier = 'chapter-c', level = 3, enumeration = '1.1.1', text = 'Chapter C'}
  -- headers[4] = {identifier = 'chapter-d', level = 1, enumeration = '2',     text = 'Chapter D'}
  -- headers[5] = {identifier = 'chapter-e', level = 2, enumeration = '2.1',   text = 'Chapter E'}
  -- headers[6] = {identifier = 'chapter-f', level = 3, enumeration = '2.1.1', text = 'Chapter F'}

  headers = {},

  -- \brief Level of headers to include in table of contents.
  --
  -- \details
  ---
  --- toc-depth equals 3

  depth = 3,

  -- \brief The counters for enumeration.
  --
  -- \brief
  --
  -- default toc-depth equals 3
  --
  -- if toc-dep equals 3 then #counters equals 3

  counters = {},

  -- \brief Width of the enumeration.
  --
  -- \details

  width = 0,

}



-- ---------------------------------------------------------------------


-- \brief Count the number of elements in a hash table.
--
-- \details
--
-- \param[in] table
--   The hash table.
--
-- \return length
--   The number of elements in the hash table.

local function lengthHashTable(table)

  local length = 0

  for index,value in pairs(table) do

    length = length + 1

  end

  return length

end



-- ---------------------------------------------------------------------



-- \brief Assemble the header.
--
-- \detils
--
-- \param[in] header
--   The header
--
-- \return header_text
--   The text of the header in one string.

local function assembleHeaderText(header)

  local header_texts = {}
  local header_text = ''

  for index,item in ipairs(header['content']) do

      if ('Str' == item['tag']) then

        header_texts[#header_texts + 1] = item['text']

      elseif ('Space' == item['tag']) then

        header_texts[#header_texts + 1] = ' '

      else
      end

    end

    header_text = table.concat(header_texts, '')

    return header_text

end



-- \brief Safe information about the header.
--
-- \details
--
-- \para[in] header
--   The header
--
-- \return void

local function saveHeaderInformation(header)

  local header_text = ''

  header_text = assembleHeaderText(header)

  storage['headers'][#storage['headers'] + 1] = {identifier  = header.identifier,
                                                 level       = tonumber(header['level']),
                                                 enumeration = '',
                                                 text        = header_text,}

end



-- \brief Filter the headers.
--
-- \details

local get_header_filter = {

  -- \brief Get header.
  --
  -- \details For each header save the information about the header.
  --
  -- \param[in] header
  --   The current header.
  --
  -- \return header
  --   The current header unaltered.

  Header = function(header)

    if    FORMAT:match('html*')
       or FORMAT:match('plain') then

      saveHeaderInformation(header)

    else
    end

  end

}



-- ---------------------------------------------------------------------



-- \brief Initialize the counters for enumeration.
--
-- \details
--
-- \param[in]
--
-- \return void

local function initializeCounter()

  for level = 1,storage['depth'],1 do

    storage['counters'][level] = 0

  end

end



-- \brief Check if we should this header in the Table of Contents (Contents).
--
-- \details
--
-- \param[in] level
--
-- \return shouldbeIncluded
--   on include: true / on not  include: false

local function shouldbeIncluded(level)

  local shouldbeIncluded = true

  if (   (level < 1)
      or (level > storage['depth'])) then
    shouldbeIncluded = false
  else
  end

  return shouldbeIncluded

end



-- \brief Increase the counter which corresponds to the level of the header.
--
-- \details
--
-- \param[in] level
--   The level of the header.
--
-- \return void

local function increaseCounter(level)

  storage['counters'][level] = storage['counters'][level] + 1;

end



-- \brief Reset the counters who correspond to the levels of the level of the
--   header.
--
-- \brief
--
-- \param[in] level
--
-- \param[in] level
--   The level of the header.
--
-- \return void

local function resetCounters(level)

  for index = (level + 1),#storage['counters'],1 do

    storage['counters'][index] = 0

  end

end



-- \brief Get the leading counters from the table.
--
-- \details From the start up to th elevel of the header.
--
-- \param[level] level
--   The level of the header.
--
-- \return leading_counters
--   The leading leading_counters

local function getLeadingConters(level)

  local leading_counters = {}

  table.move(storage['counters'], 1, level, 1, leading_counters)

  return leading_counters

end


-- \brief Create the enumeration.
--
-- \param[in] counters
--   The counters.
--
-- \return enumeration
--   The enumeration.

local function createEnumeration(counters)

   local enumeration = ''

   enumeration = table.concat(counters, '.')

   return enumeration

end



-- \brief Save the enumeration of the header.
--
-- \details
--
-- \param[in] index
--   The index of the header.
--
-- \param[in] enumeration
--   The enumeration.
--
-- \return void

local function saveEnumeration(index, enumeration)

  storage['headers'][index]['enumeration'] = enumeration

end



-- \brief Set width of the enumeration.
--
-- \details
--
-- \param[in] enumeration
--   The enumeration.
--
-- \return void

local function setWidth(enumeration)

  if (#enumeration > storage['width']) then

    storage['width'] = #enumeration

  else
  end

end



-- \brief Create string by repeating the same character or string.
--
-- \details
--
-- \param[in] character
--   The character or string.
--
-- \return space
--   The string.

function makeSpace(character, number)
  local space = ''
  for index = 1,number,1 do
    space = space .. character
  end
  return space
end



-- \brief Create and then add the enumeration to the header.
--
-- \details
--
-- \param[in] void

local function addEnumerationToHeaders()

  local contents = ''
  local leading_counters = {}
  local enumeration = ''

  for index,header in ipairs(storage['headers']) do

    if (shouldbeIncluded(header['level'])) then
    else

      goto continue

    end

    increaseCounter(header['level'])

    resetCounters(header['level'])

    leading_counters = getLeadingConters(header.level)

    enumeration = createEnumeration(leading_counters)

    saveEnumeration(index, enumeration)

    setWidth(enumeration)

    ::continue::

  end

end



--
-- \return content
--   The enumerated Table of Contents (Contents).
local function createContents()

  local contents_plain = ''
  local contents_list = pandoc.List()

  --for index,header in ipairs(storage['headers']) do
  for index = #storage['headers'],1,-1 do

    if (FORMAT:match('plain')) then

      if ('' == contents_plain) then
      contents_plain =    "\n"
      else
      end

      contents_plain =    storage['headers'][index]['enumeration']
                       .. makeSpace(' ', storage['width'] - #storage['headers'][index]['enumeration'])
                       .. ' '
                       .. storage['headers'][index]['text']
                       .. '\n'
                       .. contents_plain

    elseif (FORMAT:match('html*')) then

      contents_list:insert(1, pandoc.RawBlock('html',
                                                 '<a href="#'
                                              .. storage['headers'][index]['identifier']
                                              .. '" title="'
                                              .. storage['headers'][index]['text']
                                              .. '">'
                                              .. '<span class="toc-enumeration" style="display: inline-block; width: ' .. (storage['width'] * 0.66).. 'em;">'
                                              .. storage['headers'][index]['enumeration'] 
                                              .. '</span>'
                                              .. '<span class="toc-text" style="display: inline-block;">'
                                              -- .. makeSpace('&nbsp;', storage['width'] - #storage['headers'][index]['enumeration']) .. ' ' 
                                              .. storage['headers'][index]['text'] 
                                              .. '</span>'
                                              .. '</a><br>'
                                              )
                            )

    else
    end

  end

  if (FORMAT:match('plain')) then

    return contents_plain

  elseif (FORMAT:match('html*')) then

    return contents_list

  else

    return ''

  end

end



-- \brief Set the metadata.
--
-- \details

set_metadata_filter = {

  -- \brief Add the information for the Table of Contents (Contents).
  --
  -- \details
  --
  -- \param[in] meta
  --   The metadata.
  --
  -- \return meta
  --   The metadata now containing the Table of Contents (Contents).

  Meta = function(meta)

    local contents = ''

    if    FORMAT:match('html*')
       or FORMAT:match('plain') then

      initializeCounter()

      if (lengthHashTable(storage['headers'])> 0) then

        addEnumerationToHeaders()

        contents = createContents()

        meta['table-of-contents'] = contents

      else
      end

    else
    end

    return meta

  end

}


-- ---------------------------------------------------------------------



-- \brief Find index to the corresponding header.
--
-- \details
--
-- \param[in] identifier
--   The identifier to search for.
--
-- \param[in] headers
--   The table to search in.
--
-- \return index
--   The index found.

local function findIndex(identifier, headers)

  local index = 0

  for _,header in ipairs(headers) do

    index = index + 1

    if (identifier == header.identifier) then

      break

    else
    end

  end

  return index

end



-- \brief Set the metadata.
--
-- \details

set_header_filter = {

  -- \brief Set the Header to enumeration and title
  --
  -- \details
  --
  -- \param[in] meta
  --   The metadata.
  --
  -- \return meta
  --   The metadata now containing the Tabble of Contents.

  Header = function(header)

    local content = nil
    local index = 0

    if    FORMAT:match('html*')
       or FORMAT:match('plain') then

     index = findIndex(header.identifier, storage['headers'])

     if (index > 0) then

       content = pandoc.List(header.content)

       content:insert(1, pandoc.Space())
       content:insert(1, pandoc.Str(storage['headers'][index]['enumeration']))

       header =  pandoc.Header(header.level,
                               content,
                               header.attr,
                               header.identifier,
                               header.classes,
                               header.attributes,
                               header.tag)

      else
      end

    else
    end

    return header
  end
}



-- ---------------------------------------------------------------------



return {

  get_header_filter,
  set_metadata_filter,
  set_header_filter,

}
