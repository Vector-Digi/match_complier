# match_complier

Build OpenWrt using GitHub Actions

## Usage

- Generate `.config` files using [Stock repository](https://github.com/openwrt/openwrt) source code. ( You can change it through environment variables in the workflow file. )
- Add 3rd-part packages to [This branch](https://github.com/Vector-Digi/match_complier/tree/packages)
- Modify `prefix.sh` and `profix.sh` to apply custom settings 
- Push `.config` file to the GitHub repository.
- Select `Build OpenWrt` on the Actions page.
- Click the `Run workflow` button.
- When the build is complete, click the `Artifacts` button in the upper right corner of the Actions page to download the binaries.