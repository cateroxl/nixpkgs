{ mkDerivation, fetchurl, pkgs, lib, php }:
let
  pname = "phpstan";
  version = "0.12.57";
in
mkDerivation {
  inherit pname version;

  src = pkgs.fetchurl {
    url = "https://github.com/phpstan/phpstan/releases/download/${version}/phpstan.phar";
    sha256 = "0i1ycfmi638myl9840k4rl0z9klk0q25l8ykkkfg20kx5mdidvgc";
  };

  phases = [ "installPhase" ];
  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    install -D $src $out/libexec/phpstan/phpstan.phar
    makeWrapper ${php}/bin/php $out/bin/phpstan \
      --add-flags "$out/libexec/phpstan/phpstan.phar"
  '';

  meta = with pkgs.lib; {
    description = "PHP Static Analysis Tool";
    longDescription = ''
      PHPStan focuses on finding errors in your code without actually
      running it. It catches whole classes of bugs even before you write
      tests for the code. It moves PHP closer to compiled languages in the
      sense that the correctness of each line of the code can be checked
      before you run the actual line.
    '';
    license = licenses.mit;
    homepage = "https://github.com/phpstan/phpstan";
    maintainers = teams.php.members;
  };
}
