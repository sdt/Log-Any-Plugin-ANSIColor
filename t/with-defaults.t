use strict;
use warnings;
use Test::More;

use Log::Any::Test;
use Log::Any::Plugin;

use lib './t/lib';
use PluginTest  qw( check_log_colors );

my %colors = (
    trace => 'white on_red',
    warning => 'black on_white',
    error => 'none',
);

Log::Any::Plugin->add('Color', default => 1, %colors);

my %default_colors = do {
    no warnings 'once';
    %Log::Any::Plugin::Color::default;
};

check_log_colors(%default_colors, %colors);

done_testing;
