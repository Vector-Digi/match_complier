# match_complier

Build OpenWrt using GitHub Actions

## Usage

- Add 3rd-part packages from [This branch](https://github.com/Vector-Digi/match_complier/tree/packages)(optional)  
- Generate `.config` files using [Stock repository](https://github.com/openwrt/openwrt) source code. ( You can change it through environment variables in the workflow file. )  
- Modify `prefix.sh` and `profix.sh` to apply custom settings(optional)  
- Push `.config` file to the GitHub repository.  
- Select `Build OpenWrt` on the Actions page.  
- Click the `Run workflow` button.  
- When the build is complete, click the `Artifacts` button in the upper right corner of the Actions page to download the binaries.  