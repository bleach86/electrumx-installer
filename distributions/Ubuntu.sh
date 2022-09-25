if [ "$VERSION_ID" != "20.04" ] && [ "$VERSION_ID" != "22.04" ]; then
	_warning "Only the last two LTS versions (20.04 and 22.04) are officially supported (but this will probably work)"
fi

. distributions/base.sh
. distributions/base-systemd.sh
. distributions/base-debianoid.sh
. distributions/base-compile-rocksdb.sh

if [ $(ver "$VERSION_ID") -ge $(ver "20.04") ]; then
        newer_rocksdb=1
fi

has_rocksdb_binary=1

function install_python38 {
	$APT install -y software-properties-common || _error "Could not install package" 5
	add-apt-repository -y ppa:deadsnakes/ppa
	$APT update
	packages="python3.8 python3.8-dev python3.8-distutils"
	$APT install -y $packages || _error "Could not install package python3.7" 1
}

function binary_install_rocksdb {
	$APT install -y librocksdb-dev liblz4-dev build-essential libsnappy-dev zlib1g-dev libbz2-dev libgflags-dev || _error "Could not install packages" 1
}

function binary_uninstall_rocksdb {
    $APT remove  -y librocksdb-dev || _error "Could not remove rocksdb" 1
}

function install_leveldb {
	$APT install -y libleveldb-dev || _error "Could not install packages" 1
}

function install_pip3 {
	$APT install -y python3-pip || _error "Could not install packages" 1
}
