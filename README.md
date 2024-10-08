# Combined Nix + ROS Repo

Get a shell with all packages defined in `flake.nix` using `nix develop`

## Approach

In addition to the packages provided via `lopsided98/nix-ros-overlay` there is a ros package in `pkgs` that overlays the ros noetic packages and uses the available noetic packages to build

``` mermaid
graph BT;
    Nix-->Noetic;
    Noetic-->Local;
```

## Usage

### Terminal 1

``` bash
nix develop --command roscore
```

### Terminal 2

``` bash
nix develop --command "rosrun rospy_tutorials talker"
```

### Terminal 3

``` bash
nix develop --command "rosrun rospy_tutorials listener"
```
