# Combined Nix + ROS Repo

Get a shell with all packages defined in `flake.nix` using `nix develop`

## General Idea

This is one way to keep ROS packages and Nix in a single repository. The nice thing is that as a developer, you don't have to worry about updating something (like the version of a remote repository) since the package is built from local sources. Plus, there’s caching. A package is built only once from identical sources.

## Approach

In addition to the packages provided via `lopsided98/nix-ros-overlay` there is a ros package in `pkgs` that overlays the ros noetic packages and uses the available noetic packages to build

``` mermaid
graph BT;
    Nix-->Noetic;
    Noetic-->Local;
```

## Learning Goals

- Start the roscore and two nodes (talker, listener)

- Modify the talkers or the listeners source code

- Rebuild and start the changed node using nix develop --command "rosrun rospy_tutorials <listener/talker>"

- Change it back and observe the absence of a build when using nix develop --command "rosrun rospy_tutorials <listener/talker>"

## Usage

### Terminal 1

``` bash
nix develop --command roscore
```

### Terminal 2

``` bash
nix develop --command rosrun rospy_tutorials talker
```

### Terminal 3

``` bash
nix develop --command rosrun rospy_tutorials listener
```

## Commands Summary

``` bash
cd ~/mag-nix
git clone https://github.com/mag-nix/ros-mono.git
cd ros_mono
# Maybe use tmux
nix develop --command roscore
nix develop --command rosrun rospy_tutorials talker
nix develop --command rosrun rospy_tutorials listener
# Edit listeners text output
^C
nix develop --command rosrun rospy_tutorials listener
# And change it back
^C
nix develop --command rosrun rospy_tutorials listener
```
