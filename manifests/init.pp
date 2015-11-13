class leiningen($user="vagrant", $install_path="/home/${user}/bin/") {

  class { "leiningen::install":
    user => $user,
    install_path => $install_path,
  }
}
