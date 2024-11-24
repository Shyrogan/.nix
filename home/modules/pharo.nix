{ pkgs, config, lib, ... }: with lib; let
  cfg = config.programs.pharo;
in {
  options.programs.pharo.enable = mkEnableOption "Pharo";

  config.home.packages = optionals cfg.enable [ (pkgs.stdenv.mkDerivation (finalAttrs: rec {
    pname = "pharo";
    version = "10.3.1";

    # we use jenkins artifacts instead of a GitHub release because they contain generated sources, which are necessary to build the VM without having Pharo available.
    src = pkgs.fetchzip {
      url = "https://ci.inria.fr/pharo-ci-jenkins2/job/pharo-vm/job/pharo-10/93/artifact/build/build/packages/PharoVM-10.3.1-6cdb1e5-Linux-x86_64-c-src.tar.gz";
      hash = "sha256-Oskbo0ZMh2Wr8uY9BjA54AhFVDEuzs4AN8cpO02gdfY=";
    };

    strictDeps = true;

    buildInputs = [
      cairo
      freetype
      libffi
      libgit2
      libpng
      libuuid
      openssl
      pixman
      SDL2
    ];

    nativeBuildInputs = [
      cmake
      makeBinaryWrapper
    ];

    cmakeFlags = [
      ## Necessary to perform the bootstrapping without already having Pharo available.
      "-DGENERATED_SOURCE_DIR=."
      "-DGENERATE_SOURCES=OFF"
      "-DALWAYS_INTERACTIVE=ON"
      "-DBUILD_IS_RELEASE=ON"

      # Prevents CMake from trying to download stuff.
      "-DBUILD_BUNDLE=OFF"
    ];

    installPhase = ''
      runHook preInstall

      cmake --build . --target=install

      mkdir -p "$out/lib"
      mkdir "$out/bin"
      cp build/vm/*.so* "$out/lib/"
      cp build/vm/pharo "$out/bin/pharo"

      runHook postInstall
    '';


    preFixup =
      let
        libPath = lib.makeLibraryPath (finalAttrs.buildInputs ++ [
          stdenv.cc.cc.lib
          "$out"
        ]);
      in
      ''
        patchelf --allowed-rpath-prefixes "$NIX_STORE" --shrink-rpath "$out/bin/pharo"
        ln -s "${libgit2}/lib/libgit2.so" $out/lib/libgit2.so.1.1
        wrapProgram "$out/bin/pharo" --argv0 $out/bin/pharo --prefix LD_LIBRARY_PATH ":" "${libPath}"
      '';

    meta = {
      description = "Clean and innovative Smalltalk-inspired environment";
      homepage = "https://pharo.org";
      changelog = "https://github.com/pharo-project/pharo/releases/";
      license = lib.licenses.mit;
      longDescription = ''
        Pharo's goal is to deliver a clean, innovative, free open-source
        Smalltalk-inspired environment. By providing a stable and small core
        system, excellent dev tools, and maintained releases, Pharo is an
        attractive platform to build and deploy mission critical applications.
      '';
      maintainers = with lib.maintainers; [ ehmry ];
      mainProgram = "pharo";
      platforms = lib.platforms.linux;
    };
  })) ];
}
