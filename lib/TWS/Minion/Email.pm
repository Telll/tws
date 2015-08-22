package TWS::Minion::Email;

#use Mojo::Template;
#use Data::Dumper;
#use Net::AWS::SES;

sub send_mail {
	#my $job		= shift;
	#my $email	= shift;
	#my $photolink	= shift;

	#print "Processing email: $email, ", Dumper $photolink;
	#my $mt = Mojo::Template->new;
	#my $output = $mt->render_file($self->config->{email}->{template}, $email, $photolink);
	#print $output, $/;

	#my $aws		= $self->config->{aws};
	#my $email_conf	= $self->config->{email};
	#my $ses = Net::AWS::SES->new(access_key => $aws->{access_key}, secret_key => $aws->{secret_key});
	#my $r = $ses->send(
	#	From    => $email_conf->{from},
	#	To      => $email,
	#	Subject => $email_conf->{subject},
	#	Body    => $output,
	#);
	#if (not $r->is_success) {
	#	$job->app->log->debug("error: $@");
	#	$job->finish({ status => "error", msg => $@});
	#}
	#else {
	#	$job->finish({ status => "success", msg => "Mail to $email sent"});
	#}
}
42
