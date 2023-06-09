package myWeb::Controller::CustomController;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use DBI;
use strict;
use HTML::Entities;
use Encode;

# Action welcome render dữ liệu ra template
sub welcome ($self) {

  # Hiển thị ra thư mục template "example/welcome.html.ep" với message
  # $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');

  # Hiển thị ra thư mục template "example/welcome.html.ep" với message
  $self->render(
      template => 'myTemplates/home',
      msg      => 'Welcome to My personal website !'
  );
}
# Action hiển thị login render dữ liệu ra template
sub displayLogin($self) {
  if(&alreadyLoggedIn($self)) {
    &welcome($self);
  } else {
    $self->render(
        template         => 'myTemplates/login',
        error_message    => ''
    );
  }
}
# Action validate dữ liệu user
sub validUserCheck($self) {
    my %validUsers = (
      'JANE' => 'welcome123',
      'JILL' => 'welcome234',
      'TOM'  => 'welcome345',
      'RAJ'  => 'test123',
      'RAM'  => 'digitalocean123',
    );
    my $user = uc $self->param('username');
    my $password = $self->param('pass');
    if($validUsers{$user}) {
      if($validUsers{$user} eq $password) {
        $self->session(is_uth => 1);
        $self->session(username => $user);
        $self->session(experation => 600);
        &welcome($self);
      } else {
        $self->render(
          template      => "myTemplates/login", 
          error_message => "InvalPassword, please try again"
        );
      }
    } else {
        $self->render(
          template      => "myTemplates/login", 
          error_message => "Your are not a registered user, please get the hell out of here"
        );
    }
}
# Action login
sub alreadyLoggedIn($self) {
  return 1 if $self->session('is_auth');
  $self->render(
    template => "myTemplates/login", 
    error_message => "Your are not a registered user, please login to acess this website"
  );
  return;
}
# Action logout
sub logout($self) {
  $self->session(expires => 1);
  $self->render(
    template => "myTemplates/logout"
  );
  return;
}
# Action showData
sub show($self) {
  my $driver    = "Pg"; 
  my $database  = "learning-perl";
  my $dsn       = "DBI:Pg:dbname = learning-perl; host = localhost; port = 5432";
  my $userid    = "postgres";
  my $password  = "123456";
  my $dbh       = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;
  print "Connect database successfully\n";
  my $query = 
  qq(
    SELECT *
    FROM
    actor;
  );
  # Thực hiện câu query trên
  my $sth = $dbh->prepare($query);
  # Hiển thị lỗi nếu sai 
  my $rv = $sth->execute() or die $DBI::errstr;
  # Hiển thị số phần tử lấy ra 
  if($rv < 0) {
    print $DBI::errstr;
  }
  print "Operation done successfully\n";
  my @rows;
  while (my $row = $sth->fetchrow_hashref) {
    push @rows, $row;
  }
  $sth->finish();
  $dbh->disconnect();
  $self->render(
    rows      => \@rows,
    template  => "myTemplates/list"
  );
  return;
}
# Action addData
sub add($self) {
  my $driver    = "Pg"; 
  my $database  = "learning-perl";
  my $dsn       = "DBI:Pg:dbname = learning-perl; host = localhost; port = 5432";
  my $userid    = "postgres";
  my $password  = "123456";
  my $dbh       = DBI->connect($dsn, $userid, $password, { RaiseError => 1 }) or die $DBI::errstr;
  print "Connect database successfully\n";
  my $query = 
  qq(
    SELECT *
    FROM
    actor;
  );
  # Thực hiện câu query trên
  my $sth = $dbh->prepare($query);
  # Hiển thị lỗi nếu sai 
  my $rv = $sth->execute() or die $DBI::errstr;
  # Hiển thị số phần tử lấy ra 
  if($rv < 0) {
    print $DBI::errstr;
  }
  print "Operation done successfully\n";
  $sth->finish();
  $dbh->disconnect();
  $self->render(
    rows      => '',
    template  => "myTemplates/list"
  );
  return;
}
1;
