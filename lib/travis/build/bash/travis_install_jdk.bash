travis_install_jdk() {
  local version
  version="$1"

  case "${TRAVIS_CPU_ARCH}" in
  "arm64" | "s390x" | "ppc64le" | "amd64")
    travis_install_jdk_package "$version"
    ;;
  *)
  esac

travis_install_jdk_package() {

  local JAVA_VERSION
  JAVA_VERSION="$1"
  sudo apt-get update -yqq
  PACKAGE="adoptopenjdk-${JAVA_VERSION}-hotspot"
  if ! dpkg -s "$PACKAGE" >/dev/null 2>&1; then
    if dpkg-query -l adoptopenjdk* >/dev/null 2>&1; then
      dpkg-query -l adoptopenjdk* | grep adoptopenjdk | awk '{print $2}' | xargs sudo dpkg -P
    fi
    wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /usr/share/keyrings/adoptium.asc
    echo "deb [signed-by=/usr/share/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
    sudo apt-get update -yqq
    sudo apt-get -yqq --no-install-suggests --no-install-recommends install "$PACKAGE" || true
    sudo update-java-alternatives -s "$PACKAGE"*
  fi
}