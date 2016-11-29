if [ ! -d ~/.vagrant.d/gems/gems/vagrant-hostsupdater-* ]; then
	vagrant plugin install vagrant-hostsupdater
	vagrant plugin install vagrant-triggers
	vagrant plugin install vagrant-vbguest
else
	vagrant plugin update vagrant-hostsupdater
	vagrant plugin update vagrant-triggers
	vagrant plugin update vagrant-vbguest
fi
