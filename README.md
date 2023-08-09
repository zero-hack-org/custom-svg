# Custom-SVG

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
