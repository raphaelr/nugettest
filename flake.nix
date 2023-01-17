{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

  outputs = { nixpkgs, ... }:
  {
    packages.x86_64-linux.default =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
        pkgs.buildDotnetModule {
          pname = "foo";
          version = "0.1.0";

          dotnet-sdk = pkgs.dotnetCorePackages.sdk_7_0;
          dotnet-runtime = pkgs.dotnetCorePackages.runtime_7_0;

          src = ./.;
          projectFile = "app/app.csproj";
          nugetDeps = ./app/nuget-deps.nix;
        };
  };
}
