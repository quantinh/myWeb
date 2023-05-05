package myWeb;
use Mojo::Base 'Mojolicious', -signatures;

# This method will run once at server start
sub startup {
  
  my $self = shift;

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

  # Định tuyến router đến controller file example.pm action welcome
  # $r->get('/')->to('example#welcome');

  # Định tuyến router đến controller file CustomController.pm action welcome
  # $r->get('/')->to('CustomController#welcome');
  
  # Định tuyến router đến controller file CustomController.pm action displayLogin
  $r->get('/')->to('CustomController#displayLogin');
  
  # Định tuyến router đến controller file CustomController.pm action show
  $r->get('/show')->to('CustomController#show');

  # Định tuyến router đến controller file CustomController.pm action add
  $r->post('/add')->to('CustomController#add');
  
  # Định tuyến router đến controller file CustomController.pm action update
  $r->any('/update')->to('CustomController#update');
  
  # Định tuyến router đến controller file CustomController.pm action delete
  $r->any('/delete')->to('CustomController#delete');
  
  # Định tuyến router đến controller file CustomController.pm action validUserCheck
  $r->post('/login')->to('CustomController#validUserCheck');
  
  # Định tuyến router đến controller file CustomController.pm action logout
  $r->any('/logout')->to('CustomController#logout');
  
  # Định tuyến router đến controller login
  my $authorized = $r->under('/')->to('CustomController#alreadyLoggedIn');

}
1;
