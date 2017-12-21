# See bottom of file for license and copyright information
package Foswiki::Configure::Checkers::JQueryPlugin::JQueryVersionForOldIEs;

use strict;
use warnings;

use Foswiki::Configure::Checker ();
use File::Spec();
our @ISA = qw( Foswiki::Configure::Checker );

sub check {
    my $this      = shift;
    my $e         = '';
    my $jqversion = $Foswiki::cfg{JQueryPlugin}{JQueryVersionForOldIEs};

    # not supporting browsers < IE9 is just fine
    return '' if $jqversion eq '';

    if ( $jqversion =~ /^jquery-(\d+)\.(\d+)/ && defined $1
        and ( $1 * 1000 + $2 ) <= 1003 )
    {
        $e .= $this->WARN(<<'MESSAGE');
jQuery 1.3.x and earlier are not compatible with Foswiki default plugins
MESSAGE
    }
    if (
        not -f File::Spec->catfile(
            File::Spec->splitdir( $Foswiki::cfg{PubDir} ),
            $Foswiki::cfg{SystemWebName},
            'JQueryPlugin',
            $jqversion . '.js'
        )
      )
    {
        $e .= $this->ERROR(<<'MESSAGE');
The configured jQuery version does not exist
MESSAGE
    }

    # SMELL: Not sure if this is how to get a default value, but it works.
    my $jqdefault = $this->{item}{default};
    $jqdefault =~ s/'//g;
    if ( $jqversion ne $jqdefault ) {
        $e .= $this->WARN(
            'The selected JQuery version is not the recommended version.');
    }

    return $e;
}

1;
__END__
Foswiki - The Free and Open Source Wiki, http://foswiki.org/

Copyright (C) 2008-2017 Foswiki Contributors. Foswiki Contributors
are listed in the AUTHORS file in the root of this distribution.
NOTE: Please extend that file, not this notice.

Additional copyrights apply to some or all of the code in this
file as follows:

Copyright (C) 2000-2006 TWiki Contributors. All Rights Reserved.
TWiki Contributors are listed in the AUTHORS file in the root
of this distribution. NOTE: Please extend that file, not this notice.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version. For
more details read LICENSE in the root of this distribution.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

As per the GPL, removal of this notice is prohibited.
