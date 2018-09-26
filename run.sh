#!/bin/bash
# docker-nfsd: contained nfsd
# Copyright (C) 2018 Aleksa Sarai <cyphar@cyphar.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -e -o pipefail

function init_statd() {
	echo "[*] Starting statd."
	rpc.statd -T 600 || exit 0
}

function init_dbus() {
	echo "[*] Initialising DBus..."
	rm -rf /var/run/dbus && mkdir -p /var/run/dbus
	dbus-uuidgen --ensure
	dbus-daemon --system --fork
}

init_dbus

echo "[+] Using the following configuration:"
cat /etc/ganesha/ganesha.conf

sleep 0.5s # Wait for rpc services to start up.

echo "[*] Initialising nfs-ganesha..."
exec ganesha.nfsd -F -L /dev/stderr
