travis_install_jdk() {
  local url vendor version license jdk certlink
  jdk="$1"
  vendor="$2"
  version="$3"
  case "$version" in
  12 | 13 | 14 | 16)
    travis_install_jdk_package_bellsoft "$version"
    ;;
  *)
    travis_install_jdk_package_amazon "$version"
    ;;
  esac
}

#packages from bellsoft repo 
travis_install_jdk_package_bellsoft() {

  local JAVA_VERSION
  JAVA_VERSION="$1"
  sudo apt-get update -yqq
  PACKAGE="bellsoft-java${JAVA_VERSION}"
  wget -qO - https://download.bell-sw.com/pki/GPG-KEY-bellsoft | sudo apt-key add -
  sudo add-apt-repository  'deb [arch='$TRAVIS_CPU_ARCH'] https://apt.bell-sw.com/ stable main'
  sudo apt-get update -yqq
  sudo apt-get -yqq --no-install-suggests --no-install-recommends install "$PACKAGE" || true
  travis_cmd "export JAVA_HOME=/usr/lib/jvm/bellsoft-java${JAVA_VERSION}-${TRAVIS_CPU_ARCH}" --echo
  travis_cmd 'export PATH="$JAVA_HOME/bin:$PATH"' --echo
  sudo update-java-alternatives -s "$PACKAGE"*
}

#packages from amazon repo
travis_install_jdk_package_amazon() { 
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
