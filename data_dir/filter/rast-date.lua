-- A pandoc filter to format the date according to a format string.
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



local configuration = {

  date = '!%Y-%m-%d %H:%M:%S', -- string / e.g. '!%Y-%m-%dT%H:%M:%S'
                               -- first character equals '!': time is in UTC
                               -- retuned value of os.date() does not contain
                               --   informatin about the timezone

  timezone = '+00:00',         -- string / e.g '+02:30'
                               -- for UTC: '+00:00'

}



return{
  {

    Meta = function(meta)

      if (meta['rast-date']) then

        if (meta['rast-date']['enable']) then

          if (meta['rast-date']) then

            if (meta['rast-date']['date']) then
              configuration['date'] = meta['rast-date']['date']
            else
            end

            if (meta['rast-date']['timezone']) then
              configuration['timezone'] = meta['rast-date']['timezone']
            else
            end

          else
          end

          meta.date = ''

          if (configuration['date']) then
            meta.date = meta.date .. os.date(configuration['date'])
          else
          end

          if (#meta.date > 0) then
            meta.date = meta.date .. ' '
          else
          end

          if (configuration['timezone']) then
            meta.date = meta.date .. configuration['timezone']
          else
          end

        else
        end

      else
      end

      return meta

    end,

  }
}
