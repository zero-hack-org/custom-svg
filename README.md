![Static Badge](https://img.shields.io/badge/Ballerina-2201.7.1-1ab3ab)
<br/>
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/zero-hack-org/svg-parser)
![GitHub repo size](https://img.shields.io/github/repo-size/zero-hack-org/svg-parser)
<br/>
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
<br/>
![Twitter Follow](https://img.shields.io/twitter/follow/y_morimoto_dev?style=social)

# SVG Parser

SVG Parser for Ballerina Lang Tutorial

# Requirement

- Ballerina: https://ballerina.io/downloads/
- Docker

# SetUp & StartUp

1. Rename GitHub Username
   1. open `Config.toml`
   2. `githubUsername="yuya-morimoto"` -> `githubUsername="your-name"`
2. Create and Set GitHub Personal Access Token
   1. create from [GitHub Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#about-personal-access-tokens)
   2. open `Config.toml`
   3. `githubPersonalAccessToken="token"` -> `githubPersonalAccessToken="your-token(ex:ghp_xxxxx)"`
3. Start up application
   1. `bal run`
4. Test Request
   1. `curl -i http://localhost:8080`

# Author

- 作成者: yuya-morimoto
- E-mail: yuya-morimoto@zero-hack.jp

# Lisence

This project is licensed under the MIT License, see the [LICENSE](./LICENSE) file for details
