travis_install_jdk() {
  local url vendor version license jdk certlink
  jdk="$1"
  vendor="$2"
  version="$3"

  case "$version" in
  12 | 13 | 14 | 16)
    travis_install_jdk_package_adopt "$version"
    ;;
  *)
    travis_install_jdk_package_amazon "$version"
    ;;
  esac
}

travis_install_jdk_package_adopt() { #packages from adoptopenjdk repo

  local JAVA_VERSION
  JAVA_VERSION="$1"
  sudo apt-get update -yqq
  PACKAGE="adoptopenjdk-${JAVA_VERSION}-hotspot"
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
    sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
    sudo apt-get update -yqq
    sudo apt-get -yqq --no-install-suggests --no-install-recommends install "$PACKAGE" || true
    travis_cmd "export JAVA_HOME=/usr/lib/jvm/adoptopenjdk-${JAVA_VERSION}-hotspot-${TRAVIS_CPU_ARCH}" --echo
    travis_cmd 'export PATH="$JAVA_HOME/bin:$PATH"' --echo
    sudo update-java-alternatives -s "$PACKAGE"*
  fi
}

travis_install_jdk_package_amazon() { #packages from amazon repo

  local JAVA_VERSION
  JAVA_VERSION="$1"
  sudo apt-get update -yqq
  if [[ "$JAVA_VERSION" == "8" ]]; then
    JAVA_VERSION="1.8.0"
  fi
  PACKAGE="java-${JAVA_VERSION}-amazon-corretto-jdk"
  if ! dpkg -s "$PACKAGE" >/dev/null 2>&1; then
    wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add -
    sudo add-apt-repository 'deb https://apt.corretto.aws stable main'
    sudo apt-get update -yqq
    sudo apt-get -yqq --no-install-suggests --no-install-recommends install "$PACKAGE" || true
    travis_cmd "export JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-amazon-corretto" --echo
    travis_cmd 'export PATH="$JAVA_HOME/bin:$PATH"' --echo
    sudo update-java-alternatives -s "$PACKAGE"*
  fi
}
