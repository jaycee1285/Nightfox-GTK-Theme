{
  description = "Nordfox GTK Theme (Fausto-style install)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.default = pkgs.stdenvNoCC.mkDerivation {
        pname = "nordfox-gtk-theme";
        version = "unstable-${self.shortRev or "unknown"}";
        src = ./.;
        nativeBuildInputs = [ pkgs.gtk3 pkgs.sassc ];
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];

        installPhase = ''
          cd themes
          bash ./install.sh -s compact --tweaks outline nordfox -d $out/share/themes
        '';

        meta = with pkgs.lib; {
          description = "Nordfox GTK Theme (Fausto format)";
          homepage = "https://github.com/jaycee1285/Nightfox-GTK-Theme";
          license = licenses.gpl3Only;
          platforms = platforms.linux;
        };
      };
    };
}
