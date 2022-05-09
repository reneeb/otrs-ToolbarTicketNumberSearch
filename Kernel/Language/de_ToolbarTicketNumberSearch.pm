# --
# Kernel/Language/de_ToolbarTicketNumberSearch.pm - the German translation of ToolbarTicketNumberSearch
# Copyright (C) 2016 - 2022 Perl-Services.de, https://www.perl-services.de/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language::de_ToolbarTicketNumberSearch;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    my $Lang = $Self->{Translation} || {};

    # Custom/Kernel/Output/HTML/FilterElementPost/ToolbarTicketNumberSearch.pm
    $Lang->{'TicketNumber'} = '';

    # Kernel/Config/Files/ToolbarTicketNumberSearch.xml
    $Lang->{'Adds a search field to the toolbar.'} = '';
}

1;
