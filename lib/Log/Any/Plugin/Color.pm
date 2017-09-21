package Log::Any::Plugin::Color;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use Log::Any::Plugin::Util  qw( get_old_method set_new_method );
use Term::ANSIColor         qw( colored colorvalid );

our %default = (
    emergency  => 'red on_white',
    alert      => 'red on_white',
    critical   => 'red on_white',
    error      => 'red',
    warning    => 'yellow',
    debug      => 'cyan',
    trace      => 'blue',
);

sub install {
    my ($class, $adapter_class, %color_map) = @_;

    if ((delete $color_map{default}) || (keys %color_map == 0)) {
        # Copy the default colors, leaving any the user has specified.
        for my $method (keys %default) {
            $color_map{$method} ||= $default{$method};
        }
    }

    for my $method_name (Log::Any->logging_methods) {
        if (my $color = delete $color_map{$method_name}) {
            # Specifying none as the color name disables colorisation for that
            # method.
            next if $color eq 'none';

            if (!colorvalid($color)) {
                warn "Invalid color name \"$color\" for $method_name";
                next;
            }

            my $old_method = get_old_method($adapter_class, $method_name);
            set_new_method($adapter_class, $method_name, sub {
                my $self = shift;
                $self->$old_method(colored([$color], @_));
            });
        }
    }

    if (my @remainder = sort keys %color_map) {
        warn 'Unknown logging methods: ', join(', ', @remainder);
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Log::Any::Plugin::Color - Auto-colorize logs using Term::ANSIColor

=head1 SYNOPSIS

    use Log::Any::Plugin;

    Log::Any::Plugin->add('Color', default => 1, debug => 'blue on_white');

=head1 DESCRIPTION

Log::Any::Plugin::Color applies ANSI colors to log messages depending on the log level.

=head1 LICENSE

Copyright (C) Stephen Thirlwall.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Stephen Thirlwall E<lt>sdt@cpan.orgE<gt>

=cut

