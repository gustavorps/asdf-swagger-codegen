<div align="center">

# asdf-swagger-codegen

[swagger-codegen](https://github.com/swagger-api/swagger-codegen) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `git`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- A [Java Runtime](https://java.com/en/download) installed on your computer.

# Install

Plugin:

```shell
asdf plugin add swagger-codegen https://github.com/gustavorps/asdf-swagger-codegen.git
```

swagger-codegen:

```shell
# Show all installable versions
asdf list-all swagger-codegen

# Install specific version
asdf install swagger-codegen latest

# Set a version for the current directory
asdf set swagger-codegen latest

# Now swagger-codegen commands are available
swagger-codegen version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/gustavorps/asdf-swagger-codegen/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Gustavo Prado](https://github.com/gustavorps/)
