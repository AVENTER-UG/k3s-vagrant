#!/usr/bin/env bash
private="-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAqh5UHkl+3sGQpXplITg8XHnn0fLzQb4ibEl3jB4deS5SLwPN
K20pEXl8+KMxqoLdb7gUK9nM5pzPjenjaeGxkzyrRFwksVbn5/tM2HdZjA7GP6yg
DhUAxkkvKJyvgSkJ49bJh4OI80bKtUEGwNTn0u9SreM3lj6JPJslSuqQrZ+wlTYo
uRTYcdmyHNx1HBkfB6KFCL1qvTbBIvlY5yHPMhcaR6hXxvjvUc58XF75uEChzQ7q
gP4v4CY3sM4SgoPyHFNhh/splaL7gl7XTcQ1+4RZepnUBp9KiHIcXTS1AS4H5evI
/ZN+wjWoKKvwX0u3A+Ced4UqhsI7kFrjB7Rc2QIDAQABAoIBAQCFroeTtVWJXrp4
DxJhZHuqf/F3vl8CDpOmXKUg6plmnMvgPjCAK6vWG43lJPjmcSfpntHbE7A8mIVR
k7Ytgjm05jv/4BjFcvGSDpx4jnFD6mhHqTOtXTvalbAFTftsl/85l5OOdgKsibjJ
bmwMJEJ4M7DZDHCmFEZr5c8Ma/99L3PWTnNRM6H/v2JyXGh/QdgZp7ndvbJ7gDOr
UdCZFmpVYAfzNgV1kr2szAbEy5HJTwU1Hcf9/7LG0OxbwFZF2wTep/QoRMCot4yt
cMgTqWUBzupVxbp7nKIgci0/7mXdRCZOyJMpeRXRID6B5nGJLqXA8kFwi6g/z5qT
9L+ntYgxAoGBANV+fiWZS9X7nlNHh4Qlna0/CXmMLqwfiZR8++xwUiDJRgpYIXCM
nLRa+y5JSnm7BNPSGO1iyGTeMOt/T7AZvEg9V4H4L+dVHpZ2N5v7CvxqRMdIDwIR
zCKZbT3UXssRivYUcnGu+Kc5NsSJo0QvBwy+AqmsTiPUsfntEryR02fbAoGBAMv9
Ca9+8+wTe81MHxo5BUexVcLxu7M3e1m6Bm5rC42pkMCfyMs20eyqTiW6Eeb7OKue
9wl8lCf9gXr50QKZhyDJL/5rdloGfv/V52DXUbpbUx2oJx9+zQDbc8BH/01lHllx
pB7jLFAoRagFDSYyDowr2/7ro7SUUYq7UwdH5vZbAoGBAJlTdg9UsAUm50cSGP5L
8ZjJq+lSRvaw06MDu/3LkQAg7R9iuelV4vkYWkqcslMIgGgL/IEIL7lZZbLLxRRI
91K+U0lxUB4IoKYYksmAGxy6yViBpN2soHm8zJraGZYnrDAc8TA6JDQcv/uYidvf
FmYNVGY87AWJrKQ8ofcxl61/AoGBALpvyHxncZSgshQOsJaM6vB9eb60pTLFUK3P
QbWFjIerJKuI3kItFmxRsx70EwyjK0ZgAbTf8aEjJ0Y4MPlJTKGAf6bunLrnGQfG
frSZ1w6WDT8bwrYcdE2GRSLGKuaXtsdVAAVi58tTI2bPRxdTxMwEAgvZXkPbEzPS
xa3v333lAoGAF4x6HVcqmP1QFQ1IkuhzfNwaM/BH1c1cTvKYwmcWt07pZW9sDgnx
gPPiZ5k5gGYPZvbIUeFULRko6DiD3u8BUyYjQeLXlDm0N+SuHpycmgs5f/m0D+Rz
iDYRUDEFSyYzRTRs8UNZACIwJGR9g8XTFVZBNmNi7oThzR0K+C+OfNY=
-----END RSA PRIVATE KEY-----"
public="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqHlQeSX7ewZClemUhODxceefR8vNBviJsSXeMHh15LlIvA80rbSkReXz4ozGqgt1vuBQr2czmnM+N6eNp4bGTPKtEXCSxVufn+0zYd1mMDsY/rKAOFQDGSS8onK+BKQnj1smHg4jzRsq1QQbA1OfS71Kt4zeWPok8myVK6pCtn7CVNii5FNhx2bIc3HUcGR8HooUIvWq9NsEi+VjnIc8yFxpHqFfG+O9RznxcXvm4QKHNDuqA/i/gJjewzhKCg/IcU2GH+ymVovuCXtdNxDX7hFl6mdQGn0qIchxdNLUBLgfl68j9k37CNagoq/BfS7cD4J53hSqGwjuQWuMHtFzZ ansible"
ssh_conf="Host *\n\tIdentityFile ~/.ssh/ansible.id_rsa\n\tStrictHostKeyChecking=no\n\tUserKnownHostsFile=/dev/null\n"
dir="/home/vagrant/.ssh"

echo ">>>>>>> _COUNT    = $_COUNT"
echo ">>>>>>> _PREFIX   = $_PREFIX"
echo ">>>>>>> _HOSTNAME = $_HOSTNAME"
echo ">>>>>>> _NODE_IP  = $_NODE_IP"

mkdir -p "$dir"
echo "$private"      >  "$dir/ansible.id_rsa"
echo "$public"       >  "$dir/ansible.id_rsa.pub"
echo -ne "$ssh_conf" >> "$dir/config"
chmod 600 "$dir/ansible.id_rsa"
chmod 644 "$dir/ansible.id_rsa.pub"
chown -R vagrant: "$dir"

echo "$public"         >> "$dir/authorized_keys"
for i in `seq ${_COUNT}`
do
  A=`echo $i+20 | bc`
  if [ "$i" -le 9 ]
  then
    i=0${i}
  fi
  echo "192.168.56.$A ${_PREFIX}-${i}" >> /etc/hosts
done


sed -ie 's/^#MaxAuthTries.*/MaxAuthTries 100/g' /etc/ssh/sshd_config
curl -fsSL https://get.docker.com | sh
apt update
apt install -y squid
apt install -y net-tools
systemctl stop systemd-resolved
systemctl restart sshd
systemctl stop ufw
systemctl disable systemd-resolved
systemctl disable ufw
systemctl stop ufw
systemctl disable ufw

rm /run/systemd/resolve/stub-resolv.conf
rm /etc/resolv.conf
echo "nameserver 127.0.0.1" > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "dns_nameservers 127.0.0.1" > /etc/squid/conf.d/allow.conf
echo "http_access allow all" >> /etc/squid/conf.d/allow.conf
echo "127.0.0.1 $HOSTNAME" >> /etc/hosts

systemctl start squid
systemctl restart squid
systemctl enable docker
systemctl start docker

update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
update-alternatives --set arptables /usr/sbin/arptables-legacy
update-alternatives --set ebtables /usr/sbin/ebtables-legacy

sysctl net.bridge.bridge-nf-call-iptables=0

alias kubectl="sudo kubectl"
alias k="sudo kubectl"
alias docker="sudo docker"
alias helm="sudo helm"
alias crictl="sudo crictl"
alias weave="sudo weave"

alias >> /home/vagrant/.bashrc

set -x

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
mkdir -p /opt/cni/bin
curl -k -L https://github.com/containernetworking/plugins/releases/download/v1.7.1/cni-plugins-linux-amd64-v1.7.1.tgz | tar -xvz -C /opt/cni/bin/
curl -k -L https://raw.githubusercontent.com/AVENTER-UG/weave/refs/heads/master/weave > /usr/local/bin/weave
chmod +x /usr/local/bin/weave
/usr/local/bin/weave setup

if [ "$_HOSTNAME" == "${_PREFIX}-01" ]
then
  curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.35.1+k3s1 K3S_TOKEN=df54383b5659b9280aa1e73e60ef78fc  INSTALL_K3S_EXEC="server --node-ip ${_NODE_IP} --flannel-backend=none " sh -

  mkdir ~/.kube
  kubectl config view --raw > ~/.kube/config
  chmod 600 ~/.kube/config
else
  curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.35.1+k3s1 K3S_URL=https://${_PREFIX}-01:6443 K3S_TOKEN=df54383b5659b9280aa1e73e60ef78fc  INSTALL_K3S_EXEC="agent --node-ip ${_NODE_IP} " sh -
fi
