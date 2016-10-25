name             "monit_bin"
maintainer       "HiganWorks LLC"
maintainer_email "sawanoboriyu@higanworks.com"
license          "MIT"
description      "Installs/Configures monit_bin"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "2.0.0"
supports         "ubuntu"
supports         "smartos"
supports         "debian"

depends 'chef-sugar', '~> 3.4.0'
