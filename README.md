# NAME

Log::Any::Plugin::Color - Auto-colorize logs using Term::ANSIColor

# SYNOPSIS

    use Log::Any::Plugin;

    Log::Any::Plugin->add('Color', default => 1, debug => 'blue on_white');

# DESCRIPTION

Log::Any::Plugin::Color applies ANSI colors to log messages depending on the log level.

# LICENSE

Copyright (C) Stephen Thirlwall.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Stephen Thirlwall <sdt@cpan.org>
