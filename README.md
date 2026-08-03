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

## Java Runtime

swagger-codegen is a Java CLI, so `java` must be on your `PATH`.

The recommended way to manage a Java Runtime with asdf is the [`asdf-java`](https://github.com/halcyon/asdf-java) plugin:

```shell
# Add the asdf-java plugin
asdf plugin add java https://github.com/halcyon/asdf-java.git

# Show all installable Java distributions (Eclipse Temurin, AdoptOpenJDK, etc.)
asdf list all java | grep temurin

# Install a version (e.g. Eclipse Temurin JRE 21 LTS)
asdf install java temurin-jre-21.0.9+10.0.LTS

# Set it for the current directory
asdf set java temurin-jre-21.0.9+10.0.LTS

# Or set it globally for your user
asdf set -u java temurin-jre-21.0.9+10.0.LTS

# Verify java is available
java -version
```

Check the [asdf-java](https://github.com/halcyon/asdf-java) readme for more instructions.

# Install

Plugin:

```shell
asdf plugin add swagger-codegen https://github.com/gustavorps/asdf-swagger-codegen.git
```

swagger-codegen:

```shell
# Show all installable versions
asdf list all swagger-codegen

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
