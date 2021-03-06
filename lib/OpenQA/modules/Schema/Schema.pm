# Copyright (C) 2014 SUSE Linux Products GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

package Schema;
use base qw/DBIx::Class::Schema/;
use IO::Dir;
use SQL::SplitStatement;
use Fcntl ':mode';

# after bumping the version ...
# - run script/initdb --prepare
# - run script/upgradedb --prepare
# - edit dbicdh/SQLite/upgrade/$old-$new/001-auto.sql and add missing triggers
# - optionally add migration script dbicdh/_common/upgrade/$old-$new/...
our $VERSION = '14';

__PACKAGE__->load_namespaces;

1;
# vim: set sw=4 et:
