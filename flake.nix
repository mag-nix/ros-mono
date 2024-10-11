{
  inputs = {
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/master";
    nixpkgs.follows = "nix-ros-overlay/nixpkgs"; # Usage of different nixpkgs for fixes and adaptions
  };
  outputs = { self, nix-ros-overlay, nixpkgs }:
    nix-ros-overlay.inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            nix-ros-overlay.overlays.default
            # This overlay adds the packages of this repo
            (import ./pkgs/default.nix)
          ];
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "Example mono project";
          packages = [
            (pkgs.rosPackages.noetic.buildEnv {
                paths = [
                    # Core ROS Packages
                    # pkgs.rosPackages.noetic.ros-core
                    pkgs.rosPackages.noetic.roslaunch
                    pkgs.rosPackages.noetic.rosbash
                    pkgs.rospy-tutorials
                ];
            })
          ];

          ROS_HOSTNAME = "localhost";
          ROS_MASTER_URI = "http://localhost:11311";

          shellHook = ''
            # enable auto completion
            source ${pkgs.rosPackages.noetic.rosbash}/share/rosbash/rosbash
            # convenient aliases
            alias talker='rosrun rospy_tutorials talker'
            alias listener='rosrun rospy_tutorials listener'
          '';
        };
      });
  nixConfig = {
    extra-substituters = [
      "https://ros.cachix.org"
      "https://magnix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
      "magnix.cachix.org-1:S2LwuWtB3Di2YlymYH8avFhVdiNNWD42uV3eH3VYeGI="
    ];
  };
}
