class leiningen::install($user, $install_path, $version="2") {

  if $version == "2" {
    $executable_url = "https://raw.github.com/technomancy/leiningen/preview/bin/lein"
  }
  else {
    $executable_url = "https://github.com/technomancy/leiningen/raw/stable/bin/lein"
  }

  file { "${install_path}/lein":
    mode => '0755',
    require => [Exec["download_leiningen"],
                File["${install_path}"]]
  }

  exec { "download_leiningen" :
    command => "/usr/bin/wget -q ${executable_url} -O ${install_path}/lein",
    creates => "${install_path}/lein",
    require => [Package["wget"],
                File["${install_path}"]]
  }

  package { "wget":
    name   => "wget",
    ensure => present,
  }

  file { "${install_path}" :
    ensure => directory,
    owner => $user,
    group => $user,
    mode => '755',
    require => File["/etc/profile.d/local_bin_in_path.sh"],
  }

  file { "/etc/profile.d/local_bin_in_path.sh":
    ensure  => present,
    content => "PATH=${PATH}:${install_path}"
  }

}

