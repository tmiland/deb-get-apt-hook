# deb-get-apt-hook

 Hook deb-get into apt to get deb-get updates when running apt get

![deb-get-apt-hook.gif](https://github.com/tmiland/deb-get-apt-hook/blob/main/res/deb-get-apt-hook.gif?raw=true)

Depends on [wimpysworld/deb-get/pull/1499](https://github.com/wimpysworld/deb-get/pull/1499)

## Install

- Latest release
```bash
git clone https://github.com/tmiland/deb-get-apt-hook.git ~/.deb-get-apt-hook && \
cd ~/.deb-get-apt-hook && \
git fetch --tags && \
release="$(git describe --tags "$(git rev-list --tags --max-count=1)")" && \
git checkout $release && \
./install.sh -i
```

- Main
```bash
git clone https://github.com/tmiland/deb-get-apt-hook.git ~/.deb-get-apt-hook && \
cd ~/.deb-get-apt-hook && \
./install.sh -i
```

- Update
```bash
cd ~/.deb-get-apt-hook && \
git pull && \
./install.sh -r
```

## Donations
<a href="https://coindrop.to/tmiland" target="_blank"><img src="https://coindrop.to/embed-button.png" style="border-radius: 10px; height: 57px !important;width: 229px !important;" alt="Coindrop.to me"></img></a>

### Disclaimer 

*** ***Use at own risk*** ***

### License

[![MIT License Image](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/MIT_logo.svg/220px-MIT_logo.svg.png)](https://tmiland.github.io/deb-get-apt-hook/LICENSE)

[MIT License](https://tmiland.github.io/deb-get-apt-hook/LICENSE)