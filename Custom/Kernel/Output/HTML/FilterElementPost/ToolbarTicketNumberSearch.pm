# --
# Copyright (C) 2015 - 2017 Perl-Services.de, http://www.perl-services.de/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::FilterElementPost::ToolbarTicketNumberSearch;

use strict;
use warnings;

our @ObjectDependencies = qw(
    Kernel::Config
    Kernel::Output::HTML::Layout
    Kernel::Language
);


sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    $Self->{UserID} = $Param{UserID};

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get template name
    my $Templatename = $Param{TemplateFile} || '';
    return 1 if !$Templatename;
    return 1 if !$Param{Templates}->{$Templatename};

    return 1 if ${ $Param{Data} } !~ m{<a [^>]+ id="LogoutButton"};

    my $LayoutObject   = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $LanguageObject = $Kernel::OM->Get('Kernel::Language');
    my $ConfigObject   = $Kernel::OM->Get('Kernel::Config');

    my $Baselink    = $LayoutObject->{Baselink};
    my $Description = $LanguageObject->Translate("TicketNumber") || 'TicketNumber';

    my $Button = '';
    if ( $ConfigObject->Get('ToolbarTicketNumberSearch::ShowButtonToOpenNewWindow') ) {
        $Button = q~
            <button onclick="$('#SearchTicketNumber').attr('target','_blank');">
                <span class="fa fa-external-link"></span>
            </button>
        ~;
    }

    my $Form = qq~
        <li class="Extended SearchFulltext" style="margin-left: 10px">
            <form action="$Baselink" method="post" name="SearchTicketNumber" id="SearchTicketNumber">
                <input type="hidden" name="Action" value="AgentTicketSearch"/>
                <input type="hidden" name="Subaction" value="Search"/>
                <input type="hidden" name="CheckTicketNumberAndRedirect" value="1"/>
                <input type="text" size="25" name="TicketNumber" id="TicketNumber" placeholder="$Description" title="$Description"/>
                $Button
            </form>
        </li>
    ~;

    my $Position = $ConfigObject->Get('ToolbarTicketNumberSearch::Position') // -3;
    if ( $Position < 0 ) {
        $Position++;
        $Position *= -1;

        # place the widget in the output
        ${ $Param{Data} } =~ s{(
            <ul \s* id="ToolBar"> .*?
        ) (
            (?: (?: <li> .*? </li> \s* ){$Position} )?
            </ul>
        )}{$1 $Form $2 }xsm;
    }
    else {

        # place the widget in the output
        ${ $Param{Data} } =~ s{
            <ul \s* id="ToolBar"> \s+
                (?: <li (?:[^>]+)?> .*? </li> \s* ){$Position} \K
        }{$Form}xsm;
    }

    return 1;
}

1;
