with import <nixpkgs> {};

stdenv.mkDerivation {
name = "vagrant-env";

buildInputs = [
  vagrant
  openssh
];

SOURCE_DATE_EPOCH = 315532800;
PROJDIR = "${toString ./.}";
S_CONTAINER = "false";

shellHook = ''
  echo $NAMESERVER
  cd vagrant
  ssh-keygen -R 192.168.56.21  
  ssh-add ansible_id_rsa
  vagrant plugin repair
  vagrant up
	ssh -oStrictHostKeyChecking=no vagrant@192.168.56.21
  vagrant destroy -f
  exit
  '';
}  


