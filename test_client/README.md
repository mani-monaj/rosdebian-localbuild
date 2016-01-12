## Test ros-debian

### Local, using Vagrant (Default to i386 builds on Debian Jessie)

- Requires Vagrant and Virutalbox
- Based on [box-cutter/debian81-i386](https://atlas.hashicorp.com/box-cutter/boxes/debian81-i386) image
- You can change the target image in `Vagranfile` to test #ros-debian on otherplatforms and architecures, for example [box-cutter/debian81](
://vagrantcloud.com/box-cutter/boxes/debian81) for `amd64` tests

```bash
$ cd /path/to/rosdebian-localbuild/test_client
$ vagrant box add box-cutter/debian81-i386 # with virtualbox backend
$ vagrant up 2>&1 | tee build.log
```


