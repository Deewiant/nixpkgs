{ autonix, haskellPackages, kde4, kf55, pkgs, qt4, stdenv
, debug ? false }:

with stdenv.lib; with autonix;

let

  manifestOrig = importManifest ./manifest.nix { mirror = "mirror://kde"; };
  manifestDropKWayland = filterAttrs (n: v: n != "kwayland");
  manifest = manifestDropKWayland manifestOrig;

  dependenciesOrig = import ./dependencies.nix {};
  dependenciesFiltered = removeDependencies dependenciesOrig [
    "kwayland" "kf5" "kde4"
  ];
  dependencies = dependenciesFiltered // {
    # Automatic dependencies for breeze interferes with building Qt4 and Qt5
    # styles separately. This won't be a problem if upstream ever supports
    # building both styles in the same source tree.
    breeze = emptyDeps;
  };

  kf5 = kf55.override { inherit debug; };
  inherit (kf5) qt5;

  extraInputs = kf5 // { inherit kde4; };

  extraOutputs = {
    inherit kf5 qt5;
    poppler_qt5 = (pkgs.poppler.override { inherit qt5; }).poppler_qt5;
    breeze_qt4 = plasma5.dev.callAutonixPackage ./. "breeze" {
      withQt5 = false;
    };
    startkde = plasma5.dev.callPackage ./startkde {};
  };

  names = with pkgs; with extraOutputs; kf5.dev.names // {
    inherit epoxy;
    epub = ebook_tools;
    inherit exiv2 ffmpeg fontconfig;
    fontforge_executable = fontforge;
    inherit freetype;
    gio = glib;
    glib2 = glib;
    inherit ibus;
    mobilebroadbandproviderinfo = mobile_broadband_provider_info;
    inherit modemmanager networkmanager openconnect pciutils;
    popplerqt5 = poppler_qt5;
    inherit (kf5) prison;
    inherit pulseaudio;
    raw1394 = libraw1394;
    sensors = lm_sensors;
    inherit taglib;
    usb = libusb;
    inherit xapian;
  };

  overrides = {
    frameworkintegration = {
      buildInputs = [ plasma5.oxygen-fonts ];
    };
    kwin = {
      buildInputs = with pkgs.xlibs; [ libICE libSM libXcursor ];
    };
    libkscreen = {
      buildInputs = with pkgs.xlibs; [ libXrandr ];
    };
    plasma-desktop = {
      buildInputs = with pkgs.xlibs; [ pkgs.libcanberra libxkbfile libXcursor ];
    };
    plasma-workspace = {
      buildInputs = with pkgs.xlibs; [ libSM libXcursor pkgs.pam ];
    };
    powerdevil = {
      buildInputs = with pkgs.xlibs; [ libXrandr ];
    };
  };

  plasma5 = autonix.generateCollection ./. {
    inherit dependencies extraInputs extraOutputs manifest names overrides;
    deriver = kf5.dev.mkDerivation;
  };

in assert builtins.isAttrs dependenciesOrig; plasma5