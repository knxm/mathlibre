#
# -*- Perl -*-
# $Id: pdf.pl,v 1.22.4.16 2006/04/30 08:27:51 opengl2772 Exp $
# Copyright (C) 1997-2000 Satoru Takabayashi ,
#               1999 NOKUBI Takatsugu ,
#               2000-2006 Namazu Project All rights reserved.
#     This is free software with ABSOLUTELY NO WARRANTY.
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either versions 2, or (at your option)
#  any later version.
# 
#  This program is distributed in the hope that it will be useful
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
#  02111-1307, USA
#
#  This file must be encoded in EUC-JP encoding
#

package pdf;
use strict;
require 'util.pl';
require 'gfilter.pl';

my $pdfconvpath = undef;
my $pdfinfopath = undef;
my @pdfconvopts = undef;
my @pdfinfoopts = undef;
my $pdfconvver = 0;
my $pdfinfover = 0;

sub mediatype() {
    return ('application/pdf');
}

sub status() {
    $pdfconvpath = util::checkcmd('pdftotext');
    $pdfinfopath = util::checkcmd('pdfinfo');
    if (defined $pdfconvpath) {
        my @cmd = ("$pdfconvpath");
        my $result = "";
        my $status = util::syscmd(
            command => \@cmd,
            option => {
                "stdout" => "/dev/null",
                "stderr" => \$result,
                "mode_stdout" => 'wt',
                "mode_stderr" => 'wt',
            },
        );
        if ($result =~ m/^pdftotext\s+version\s+([0-9]+\.[0-9]+)/m) {
            $pdfconvver = $1;
        }
        if (util::islang("ja")) {
            if ($pdfconvver >= 0.10) {
                @pdfconvopts = ('-q', '-raw', '-enc', 'EUC-JP');
            } else {
                @pdfconvopts = ('-q', '-raw', '-eucjp');
            }
        } else {
            @pdfconvopts = ('-q', '-raw');
        }
        if (defined $pdfinfopath) {
            my @cmd = ("$pdfinfopath");
            my $result = "";
            my $status = util::syscmd(
                command => \@cmd,
                option => {
                    "stdout" => "/dev/null",
                    "stderr" => \$result,
                    "mode_stdout" => 'wt',
                    "mode_stderr" => 'wt',
                },
            );
            if ($result =~ /^pdfinfo\s+version\s+([0-9]+\.[0-9]+)/) {
                $pdfinfover = $1;
            }
            if (util::islang("ja")) {
                if ($pdfinfover >= 2.02) {
                    @pdfinfoopts = ('-enc', 'EUC-JP');
                } else {
                    @pdfinfoopts = ();
                }
            } else {
                @pdfinfoopts = ();
            }
        }
        return 'yes';
    }
    return 'no';
}

sub recursive() {
    return 0;
}

sub pre_codeconv() {
    return 0;
}

sub post_codeconv () {
    return 0;
}

sub add_magic ($) {
    return;
}

sub filter ($$$$$) {
    my ($orig_cfile, $cont, $weighted_str, $headings, $fields)
      = @_;
    my $cfile = defined $orig_cfile ? $$orig_cfile : '';

    util::vprint("Processing pdf file ... (using  '$pdfconvpath')\n");

    my $tmpfile = util::tmpnam('NMZ.pdf');
    my $tmpfile2 = util::tmpnam('NMZ.pdf2');
    {
        my $fh = util::efopen("> $tmpfile");
        print $fh $$cont;
        util::fclose($fh);
    }
    my @cmd = ($pdfconvpath, @pdfconvopts, $tmpfile, $tmpfile2);
    my $status = util::syscmd(
        command => \@cmd,
        option => {
            "stdout" => "/dev/null",
            "stderr" => "/dev/null",
        },
    );
    unless (-e $tmpfile2) {
        unlink $tmpfile;
        return 'Unable to convert pdf file (maybe copying protection)';
    }
    {
        my $fh = util::efopen("< $tmpfile2");
        my $size = util::filesize($fh);
        if ($size == 0) {
            util::fclose($fh);
            unlink $tmpfile;
            unlink $tmpfile2;
            return "Unable to convert file ($pdfconvpath error occurred)";
        }
        if ($size > $conf::FILE_SIZE_MAX) {
            util::fclose($fh);
            unlink $tmpfile;
            unlink $tmpfile2;
            return 'Too large pdf file';
        }
        $$cont = util::readfile($fh);
        util::fclose($fh);
    }

    # codeconv::toeuc($cont);
    codeconv::codeconv_document($cont);

    if (defined $pdfinfopath) {
        my @cmd = ($pdfinfopath, @pdfinfoopts, $tmpfile);
        my $result = "";
        my $status = util::syscmd(
            command => \@cmd,
            option => {
                "stdout" => \$result,
                "stderr" => "/dev/null",
                "mode_stdout" => 'wt',
                "mode_stderr" => 'wt',
            },
        );
        if ($result =~ /Title:\s+(.*)/) { # or /Subject:\s+(.*)/
            $fields->{'title'} = $1;
            if ($fields->{'title'} =~ /<unicode>/) {
                delete $fields->{'title'};
            }
            elsif ($fields->{'title'} =~ /^\s*$/) {
                delete $fields->{'title'};
            }
        }
        if ($result =~ /Author:\s+(.*)/) {
            $fields->{'author'} = $1;
            if ($fields->{'author'} =~ /<unicode>/) {
                delete $fields->{'author'};
            }
            elsif ($fields->{'author'} =~ /^\s*$/) {
                delete $fields->{'author'};
            }
        }
    }

    unlink $tmpfile;
    unlink $tmpfile2;
    
    # Zenkaku-space handling bug fix (before pdftotext-0.90)
    if (util::islang("ja") && $pdfconvver <= 0.10) {
        $$cont =~ s/\xa1\xa0/\xa1\xa1/g;
    }

    gfilter::line_adjust_filter($cont);
    gfilter::line_adjust_filter($weighted_str);
    gfilter::white_space_adjust_filter($cont);
    $fields->{'title'} = gfilter::filename_to_title($cfile, $weighted_str)
        unless $fields->{'title'};
    gfilter::show_filter_debug_info($cont, $weighted_str,
                                    $fields, $headings);

    return undef;
}

1;
