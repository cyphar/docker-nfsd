## `docker-nfsd` ##

A really simple contained `nfsd` (using `ganesha-nfs`) that runs within Docker.
To use this do the following:

```
% docker run -d --restart=always --init --name nfsd \
        --cap-add sys_admin --cap-add dac_read_search \
        -v $EXPORT_PATH:/export/$NAME:ro \
        -v /run/rpcbind.sock:/run/rpcbind.sock:rw \
        --publish={2049:2049,52049:52049}/{tcp,udp} \
        cyphar/nfsd:latest
```

If you have issues, feel free to report them but I don't remember how I made
this work in the first place to be honest. :P

### License ###

`docker-nfsd` is licensed under the GNU GPLv3 (or later).

```
docker-nfsd: contained nfsd
Copyright (C) 2018 Aleksa Sarai <cyphar@cyphar.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```
