![Static Badge](https://img.shields.io/badge/Ballerina-2201.7.1-1ab3ab)
<br/>
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/zero-hack-org/svg-parser)
![GitHub repo size](https://img.shields.io/github/repo-size/zero-hack-org/svg-parser)
<br/>
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
<br/>
[![codecov](https://codecov.io/gh/zero-hack-org/svg-parser/branch/main/graph/badge.svg?token=83AFHJOCY2)](https://codecov.io/gh/zero-hack-org/svg-parser)
<br/>
![Twitter Follow](https://img.shields.io/twitter/follow/y_morimoto_dev?style=social)

## svg-parser

Ballerina Lang SVG Parser

### Usage

1. Generate Config.toml

   ```bash
   cp BaseConfig.toml Config.toml
   ```

2. Custom Config.toml /.env is also possible)
   | Argument name | Description |
   | ------------------ | ---------------------------------------------------- |
   | svg_parser.port | Custom port |
   | [zerohack.github](https://central.ballerina.io/zerohack/github).githubUsername | Your github username |
   | [zerohack.github](https://central.ballerina.io/zerohack/github).githubPersonalAccessToken | Your [github personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#about-personal-access-tokens) |

3. Start up application

   ```bash
   bal run
   ```

4. Demo Request

   ```bash
   curl -i http://localhost:8080/contributions
   ```

5. Result Demo<br/>
   ![スクリーンショット 0005-09-07 0 56 27](https://github.com/zero-hack-org/svg-parser/assets/84908365/b10efc39-5aa7-47d6-91ff-81d255ff4738)

   

### Useful links

- Discuss code changes of the Ballerina project via [yuya-morimoto@zero-hack.jp](yuya-morimoto@zero-hack.jp).

### License

This project is licensed under the Apache-2.0 License, see the [LICENSE](./LICENSE) file for details
