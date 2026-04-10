# External Toolchains

Clone the open-source EDA tools into this directory. Large binaries
(multi-GB) are gitignored — install locally.

```bash
cd repos
git clone https://github.com/hpretl/iic-osic-tools.git
git clone https://github.com/YosysHQ/oss-cad-suite-build.git oss-cad-suite
cd iic-osic-tools
./start_x.sh          # first pull is ~12 GB
```
