# Guide to generate RPMs for OpenBangla Keyboard

- Clone the repo : <br>
```bash
git clone --recursive https://github.com/OpenBangla/OpenBangla-Keyboard.git && cd OpenBangla-Keyboard
```

- There is a tool in the repo for auto-compiling inside a toolbox for any specified distro.

- Checkout branch and update submodules : <br >
`git checkout develop` or `git checkout master` and `git submodule update`
- Browse to the repo directory : `cd OpenBangla-Keyboard`
- Install dependencies : `sudo dnf -y install @buildsys-build rust cargo cmake qt5-qtdeclarative-devel libzstd-devel fcitx5 fcitx5-devel ibus ibus-devel ninja-build curl meson git`

1. Generate binary RPMs
- ibus : `cmake -Bbuild-ibus-fedora -GNinja -DCPACK_GENERATOR="RPM" -DCMAKE_INSTALL_PREFIX="/usr" -DENABLE_IBUS=ON && ninja package -C build-ibus-fedora`
- fcitx : `cmake -Bbuild-fcitx-fedora -GNinja -DCPACK_GENERATOR="RPM" -DCMAKE_INSTALL_PREFIX="/usr" -DENABLE_FCITX=ON && ninja package -C build-fcitx-fedora`

2. Generate source RPMs (submittable to copr)
- ibus : `cmake -Bbuild-ibus-fedora -GNinja -DCPACK_RPM_PACKAGE_SOURCES="on" -DCPACK_RPM_SOURCE_PKG_PACKAGING_INSTALL_PREFIX="/usr" -DCPACK_RPM_BUILDREQUIRES="make automake gcc gcc-c++ clang rust cargo cmake qt5-qtdeclarative-devel libzstd-devel fcitx5 fcitx5-devel ibus ibus-devel ninja-build curl meson git" -DCPACK_GENERATOR="RPM" -DCMAKE_INSTALL_PREFIX="/usr" -DENABLE_IBUS=ON && ninja package -C build-ibus-fedora`
- fcitx : `cmake -Bbuild-fcitx-fedora -GNinja -DCPACK_RPM_PACKAGE_SOURCES="on" -DCPACK_RPM_BUILDREQUIRES="make automake gcc gcc-c++ clang rust cargo cmake qt5-qtdeclarative-devel libzstd-devel fcitx5 fcitx5-devel ibus ibus-devel ninja-build curl meson git" -DCPACK_GENERATOR="RPM" -DCMAKE_INSTALL_PREFIX="/usr" -DENABLE_FCITX=ON && ninja package -C build-fcitx-fedora`

** I am still unclear about what `-DCPACK_RPM_SOURCE_PKG_PACKAGING_INSTALL_PREFIX="/usr"` does **
** ibus builds with the argument enabled, fcitx doesn't have that **