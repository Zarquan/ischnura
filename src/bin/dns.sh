#!/bin/bash
# <meta:header>
#   <meta:licence>
#     Copyright (C) 2013 by Wizzard Solutions Ltd, ischnura@metagrid.co.uk
#
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#  
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <http://www.gnu.org/licenses/>.
#   </meta:licence>
# </meta:header>
#
#
binpath=$(dirname $(readlink -f ${0}))

if [ ! -f "${binpath}/utils" ]
then
    echo "ERROR : unable to load utils [${binpath}/utils]"
    exit -1
else
    source "${binpath}/utils"
fi

type=${1:-'live'}


datpath=$(dirname ${binpath})/dat
datfile=${datpath}/${type:?}-address.dat
if [ ! -f "${datfile}" ]
then
    echo "ERROR : unable to find data file [${datfile}]"
    exit -1
fi

echo ""
echo ""
for name in $(cat "${datfile}" | tabify | cut -f 2)
do

    if [ "${name}" != '' ]
    then
        dhcp=$(${binpath}/netinfo ${name:?} 'mac'  "${type:?}")
        ipv4=$(${binpath}/netinfo ${name:?} 'ipv4' "${type:?}")
        ipv6=$(${binpath}/netinfo ${name:?} 'ipv6' "${type:?}")

        printf "\n"
        printf "\n%-10s      A    %s" ${name} ${ipv4}
        printf "\n%-10s      AAAA %s" ${name} ${ipv6}
    fi

done
echo ""
echo ""


echo ""
echo ""
for name in $(cat "${datfile}" | tabify | cut -f 2)
do

    if [ "${name}" != '' ]
    then
        dhcp=$(${binpath}/netinfo ${name:?} 'mac'  "${type:?}")
        ipv4=$(${binpath}/netinfo ${name:?} 'ipv4' "${type:?}")
        ipv6=$(${binpath}/netinfo ${name:?} 'ipv6' "${type:?}")

        ipv7=${ipv6//:/}
        ipv8=${ipv7:16}
        ipv9=$(echo ${ipv8} | rev)
        ipvA=$(echo ${ipv9} | sed 's/\([[:alnum:]]\)\([[:alnum:]]\)/\1.\2/g')
        ipvB=$(echo ${ipvA} | sed 's/\([[:alnum:]]\)\([[:alnum:]]\)/\1.\2/g')
    
        domain=virtual.metagrid.co.uk.
        printf "\n%-10s      IN    PTR    %s.%s" ${ipvB} ${name} ${domain}
    fi

done
echo ""
echo ""


echo ""
echo ""
for name in $(cat "${datfile}" | tabify | cut -f 2)
do

    if [ "${name}" != '' ]
    then
        dhcp=$(${binpath}/netinfo ${name:?} 'mac'  "${type:?}")
        ipv4=$(${binpath}/netinfo ${name:?} 'ipv4' "${type:?}")
        ipv6=$(${binpath}/netinfo ${name:?} 'ipv6' "${type:?}")

        ipv7=$(echo "${ipv4}" | cut -d '.' -f 4)
    
        domain=virtual.metagrid.co.uk.
        printf "\n%-2s    IN    PTR    %s.%s" ${ipv7} ${name} ${domain}
    fi

done
echo ""
echo ""




