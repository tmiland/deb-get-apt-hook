#!/usr/bin/env bash

install() {
	echo "Installing deb get apt hook"
  cp -rp ./80deb-get /etc/apt/apt.conf.d/80deb-get
  chmod 644 /etc/apt/apt.conf.d/80deb-get
  cp -rp ./deb_get_apt_hook.sh /usr/bin/deb_get_apt_hook.sh
  chmod 755 /usr/bin/deb_get_apt_hook.sh
	echo "Done."
}

uninstall() {
echo "Unstalling deb get apt hook"
rm -rf /etc/apt/apt.conf.d/80deb-get
rm -rf /usr/bin/deb_get_apt_hook.sh
echo "Done."
}

reinstall() {
  uninstall
  install
}

usage() {
  cat <<'EOF'

  Options are:

    --install                      | -i
    --uninstall                    | -u
    --reinstall                    | -r
EOF
}

ARGS=()
while [[ $# -gt 0 ]]
do
  case $1 in
    --help | -h)
      usage
      exit 0
      ;;
    --install | -i)
      install
      exit 0
      ;;
    --uninstall | -u)
      uninstall
      exit 0
      ;;
    --reinstall | -r)
      reinstall
      exit 0
      ;;
    --*|-*)
      printf '..%s..' "$1\\n\\n"
      usage
      exit 1
      ;;
    *)
      ARGS+=("$1")
      shift
      ;;
  esac
done

set -- "${ARGS[@]}"

exit 0
