use strict;
use warnings;

use tws;

my $app = tws->apply_default_middlewares(tws->psgi_app);
$app;

